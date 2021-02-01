class CreateAnswerChoice < ActiveRecord::Migration[6.0]
  def change
    create_table :answer_choices do |t|
      t.integer(:question_id, { null: false })
      t.text(:text, { null: false })

      t.timestamps
    end

    add_foreign_key(:answer_choices, :questions, { column: :question_id, primary_key: :id })
  end
end
