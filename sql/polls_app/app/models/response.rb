class Response < ApplicationRecord
    validates(:user_id, { presence: true })
    validates(:answer_choice_id, { presence: true })
    validate(:not_duplicate_response, :not_author_response)

    def not_duplicate_response
        if self.sibling_reponses.where( user_id: self.user_id ).exists?
            errors[:user_id] << 'has already responded to this question.'
        end
    end

    def not_author_response
        if self.question.poll.author_id == self.user_id
            errors[:user_id] << 'is the author of the poll. Authors cannot respond to their polls.'
        end
    end

    belongs_to(:respondant, **{
        class_name: 'User',
        foreign_key: :user_id,
        primary_key: :id
    })

    belongs_to(:answer_choice, **{
        class_name: 'AnswerChoice',
        foreign_key: :answer_choice_id,
        primary_key: :id
    })

    has_one(:question, **{
        through: :answer_choice,
        source: :question
    })

    def sibling_reponses
        self.question.responses.where.not(id: self.id)
    end
end