require 'sqlite3'
require_relative 'questionsdbconnection'

class Replies
    def self.all
        QuestionsDBConnection.instance.execute("SELECT * FROM replies").map { |data| Replies.new(data) }
    end

    def self.find_by_id(id)
        data = QuestionsDBConnection.instance.execute(<<-SQL, id)
            SELECT
                *
            FROM
                replies
            WHERE
                id = ?
        SQL
        data.map { |datum| Replies.new(datum) }
    end

    def self.find_by_user_id(user_id)
        data = QuestionsDBConnection.instance.execute(<<-SQL, user_id)
            SELECT
                *
            FROM
                replies
            WHERE
                user_id = ?
        SQL
        data.map { |datum| Replies.new(datum) }
    end

    def self.find_by_question_id(question_id)
        data = QuestionsDBConnection.instance.execute(<<-SQL, question_id)
            SELECT
                *
            FROM
                replies
            WHERE
                question_id = ?
        SQL
        data.map { |datum| Replies.new(datum) }
    end

    def self.find_by_author(fname, lname)
        data = QuestionsDBConnection.instance.execute(<<-SQL, fname, lname)
            SELECT
                *
            FROM
                replies
            JOIN
                users
            ON
                users.id = replies.user_id
            WHERE
                fname = ? AND lname = ?)
        SQL
        data.map { |datum| Replies.new(datum) }
    end
        

    attr_accessor :id, :user_id, :question_id, :parent_id, :body

    def initialize(options)
        @id = options['id']
        @user_id = options['user_id']
        @question_id = options['question_id']
        @parent_id = options['parent_id']
        @body = options['body']
    end

    def author
        Users.find_by_id(@user_id)
    end

    def question
        Questions.find_by_id(@question_id)
    end

    def parent_reply
        Replies.find_by_id(@parent_id)
    end

    def child_replies
        QuestionsDBConnection.instance.execute(<<-SQL, @id)
            SELECT
                *
            FROM
                replies
            WHERE
                @parent_id = ?
        SQL
    end

    def save
        if @id
            QuestionsDBConnection.instance.execute(<<-SQL, @user_id, @question_id, @parent_id, @body, @id)
                UPDATE
                    replies
                SET
                    user_id = ?, question_id = ?, parent_id = ?, body = ?
                WHERE
                    id = ?
            SQL
        else
            data = QuestionsDBConnection.instance.execute(<<-SQL, @user_id, @question_id, @parent_id, @body)
                INSERT INTO
                    questions (user_id, question_id, parent_id, body)
                VALUES
                    (?, ?, ?, ?)
            SQL
            @id = QuestionsDBConnection.instance.last_insert_row_id
        end
    end
end
