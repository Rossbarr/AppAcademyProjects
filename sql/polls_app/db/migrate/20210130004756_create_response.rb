class CreateResponse < ActiveRecord::Migration[6.0]
  def change
    create_table :responses do |t|
      t.integer(:user_id, { null: false })
      t.integer(:answer_choice_id, { null: false })

      t.timestamps
    end

    add_foreign_key(:responses, :users, { column: :user_id, primary_key: :id })
    add_foreign_key(:responses, :answer_choices, { column: :answer_choice_id, primary_key: :id })
  end
end
