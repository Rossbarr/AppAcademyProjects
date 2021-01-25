require 'sqlite3'
require_relative 'questionsdbconnection'

class Users
    def self.all
        QuestionsDBConnection.instance.execute("SELECT * FROM users").map { |data| Users.new(data) }
    end

    def self.find_by_id(id)
        data = QuestionsDBConnection.instance.execute(<<-SQL, id)
            SELECT
                *
            FROM
                users
            WHERE
                id = ?
        SQL
        data.map { |datum| Users.new(datum) }
    end

    def self.find_by_fname(fname)
        data = QuestionsDBConnection.instance.execute(<<-SQL, fname)
            SELECT
                *
            FROM
                users
            WHERE
                fname = ?
        SQL
        data.map { |datum| Users.new(datum) }
    end

    def self.find_by_lname(lname)
        data = QuestionsDBConnection.instance.execute(<<-SQL, lname)
            SELECT
                *
            FROM
                users
            WHERE
                lname = ?
        SQL
        data.map { |datum| Users.new(datum) }
    end

    def self.find_by_name(fname, lname)
        data = QuestionsDBConnection.instance.execute(<<-SQL, fname, lname)
            SELECT
                *
            FROM
                users
            WHERE
                fname = ? AND lname = ?
        SQL
        data.map { |datum| Users.new(datum) }
    end

    attr_accessor :id, :fname, :lname

    def initialize(options)
        @id = options['id']
        @fname = options['fname']
        @lname = options['lname']
    end

    def authored_questions
        Questions.find_by_author_id(@id)
    end

    def authored_replies
        Replies.find_by_user_id(@id)
    end

    def followed_questions
        QuestionFollows.followed_questions_for_user_id(@id)
    end

    def liked_questions
        QuestionLikes.liked_questions_for_user_id(@id)
    end
    
    def average_karma
        data = QuestionsDBConnection.instance.execute(<<-SQL, @id)
            SELECT
                COUNT(question_likes.user_id) / CAST(COUNT(DISTINCT(questions.id)) AS FLOAT)
            FROM
                questions
            LEFT OUTER JOIN
                question_likes
            ON
                questions.id = question_likes.question_id
            WHERE
                author_id = ?
        SQL
        data[0]["COUNT(question_likes.user_id) / CAST(COUNT(DISTINCT(questions.id)) AS FLOAT)"]
    end

    def save
        if @id
            QuestionsDBConnection.instance.execute(<<-SQL, @fname, @lname, @id)
                UPDATE
                    users
                SET
                    fname = ?, lname = ?
                WHERE
                    id = ?
            SQL
        else
            data = QuestionsDBConnection.instance.execute(<<-SQL, @fname, @lname)
                INSERT INTO
                    users (fname, lname)
                VALUES
                    (?, ?)
            SQL
            @id = QuestionsDBConnection.instance.last_insert_row_id
        end
    end
end