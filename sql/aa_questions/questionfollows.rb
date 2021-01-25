require 'sqlite3'
require_relative 'questionsdbconnection'

class QuestionFollows
    def self.all
        QuestionsDBConnection.instance.execute("SELECT * FROM question_follows").map { |data| Replies.new(data) }
    end

    def self.followers_for_question_id(question_id)
        data = QuestionsDBConnection.instance.execute(<<-SQL, question_id)
            SELECT
                *
            FROM
                users
            JOIN
                question_follows
            ON
                users.id = question_follows.user_id
            WHERE
                question_id = ?
        SQL
        data.map { |datum| Users.new(datum) }
    end

    def self.followed_questions_for_user_id(user_id)
        data = QuestionsDBConnection.instance.execute(<<-SQL, user_id)
            SELECT
                *
            FROM
                questions
            JOIN
                question_follows
            ON
                questions.id = question_follows.question_id
            WHERE
                user_id = ?
        SQL
        data.map { |datum| Questions.new(datum) }
    end

    def self.most_followed_questions(n)
        data = QuestionsDBConnection.instance.execute(<<-SQL, n)
            SELECT DISTINCT
                question_id, count(user_id), *
            FROM
                question_follows
            JOIN
                questions
            ON
                questions.id = question_follows.question_id
            ORDER BY
                count(user_id)
            LIMIT
                ?
        SQL
        data.map { |datum| Questions.new(datum) }
    end

    def initialize(options)
        @user_id = options['user_id']
        @question_id = options['question_id']
    end
end