require 'sqlite3'
require_relative 'questionsdbconnection'

class Questions
    def self.all
        QuestionsDBConnection.instance.execute("SELECT * FROM questions").map { |data| Questions.new(data) }
    end

    def self.find_by_id(id)
        data = QuestionsDBConnection.instance.execute(<<-SQL, id)
            SELECT
                *
            FROM
                questions
            WHERE
                id = ?
        SQL
        data.map { |datum| Questions.new(datum) }
    end

    def self.find_by_author_id(author_id)
        data = QuestionsDBConnection.instance.execute(<<-SQL, author_id)
            SELECT
                *
            FROM
                questions
            WHERE
                author_id = ?
        SQL
        data.map { |datum| Questions.new(datum) }
    end

    def self.find_by_author(fname, lname)
        data = QuestionsDBConnection.instance.execute(<<-SQL, fname, lname)
            SELECT
                *
            FROM
                questions
            JOIN
                users
            ON
                users.id = questions.author_id
            WHERE
                fname = ? AND lname = ?
        SQL
        data.map { |datum| Questions.new(datum) }
    end

    def self.most_followed(n = 10)
        QuestionFollows.most_followed_questions(n)
    end

    def self.most_liked(n = 10)
        QuestionLikes.most_liked_questions(n)
    end

    attr_accessor :id, :title, :body, :author_id

    def initialize(options)
        @id = options['id']
        @title = options['title']
        @body = options['body']
        @author_id = options['author_id']
    end

    def author
        Users.find_by_id(@author_id)
    end

    def replies
        Replies.find_by_question_id(@id)
    end

    def followers
        QuestionFollows.followers_for_question_id(@id)
    end

    def likers
        QuestionLikes.likers_for_question_id(@id)
    end

    def num_likes
        QuestionLikes.num_likes_for_question_id(@id)
    end

    def save
        if @id
            QuestionsDBConnection.instance.execute(<<-SQL, @title, @body, @author_id, @id)
                UPDATE
                    questions
                SET
                    title = ?, body = ?, author_id = ?
                WHERE
                    id = ?
            SQL
        else
            data = QuestionsDBConnection.instance.execute(<<-SQL, @title, @body, @author_id)
                INSERT INTO
                    questions (title, body, author_id)
                VALUES
                    (?, ?, ?)
            SQL
            @id = QuestionsDBConnection.instance.last_insert_row_id
        end
    end
end