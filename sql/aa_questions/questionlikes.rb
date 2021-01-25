require 'sqlite3'
require_relative 'questionsdbconnection'

class QuestionLikes
    def self.all
        QuestionsDBConnection.instance.execute("SELECT * FROM question_likes").map { |data| Replies.new(data) }
    end

    def self.likers_for_question_id(question_id)
        data = QuestionsDBConnection.instance.execute(<<-SQL, question_id)
            SELECT
                *
            FROM
                users
            JOIN
                question_likes
            ON
                users.id = question_likes.user_id
            WHERE
                question_id = ?
        SQL
        data.map { |datum| Users.new(datum) }
    end

    def self.num_likes_for_question_id(question_id)
        data = QuestionsDBConnection.instance.execute(<<-SQL, question_id)
            SELECT
                count(user_id)
            FROM
                users
            JOIN
                question_likes
            ON
                users.id = question_likes.user_id
            WHERE
                question_id = ?
        SQL
        data[0]["count(user_id)"]
    end

    def self.liked_questions_for_user_id(user_id)
        data = QuestionsDBConnection.instance.execute(<<-SQL, user_id)
            SELECT
                *
            FROM
                questions
            JOIN
                question_likes
            ON
                questions.id = question_likes.question_id
            WHERE
                user_id = ?
        SQL
        data.map { |datum| Questions.new(datum) }
    end

    def self.most_liked_questions(n)
        data = QuestionsDBConnection.instance.execute(<<-SQL, n)
            SELECT DISTINCT
                question_id, count(user_id), *
            FROM
                question_likes
            JOIN
                questions
            ON
                questions.id = question_likes.question_id
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