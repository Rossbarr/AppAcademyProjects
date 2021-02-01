class User < ApplicationRecord
    validates(:username, { presence: true, uniqueness: true })

    has_many(:polls, **{
        class_name: 'Poll',
        foreign_key: :author_id,
        primary_key: :id
    })

    has_many(:responses, **{
        class_name: 'Response',
        foreign_key: :user_id,
        primary_key: :id
    })

    def completed_polls
        """
        SQL->
            SELECT
                polls.*, COUNT(questions.id) AS num_questions
            FROM 
                polls
            JOIN
                questions
            ON
                questions.poll_id = polls.id
            LEFT OUTER JOIN
                (SELECT
                    responses.*
                JOIN
                    users
                ON
                    users.id = responses.user_id
                WHERE
                    responses.id = [[self.id]])
            ON
                responses.user_id = user.id
            HAVING
                num_questions > num_responses ??
        SQL
        """
    end
end