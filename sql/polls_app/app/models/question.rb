class Question < ApplicationRecord
    validates(:poll_id, { presence: true })
    validates(:text, { presence: true })

    belongs_to(:poll,
        class_name: 'Poll',
        foreign_key: :poll_id,
        primary_key: :id
    )

    has_many(:answer_choices,
        class_name: 'AnswerChoice',
        foreign_key: :question_id,
        primary_key: :id
    )

    has_many(:responses, 
        through: :answer_choices,
        source: :responses
    )

    def results
        """
        SQL->
            SELECT
                answer_choices.*, COUNT(responses.user_id)
            FROM
                answer_choices
            LEFT OUTER JOIN
                responses
            ON
                responses.answer_choice_id = answer_choices.id
            WHERE
                answer_choices.question_id = [[self.id]]
            GROUP BY
                answer_choice.id
        """

        results = {}
        self.answer_choices
            .select( :id, :text, 'COUNT(responses.user_id) AS num_responses')
            .left_outer_joins(:responses)
            .group( :id )
            .each{ |choice| results[choice.text] = choice.num_responses }

        results
    end
end