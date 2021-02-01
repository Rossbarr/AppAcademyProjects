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
end