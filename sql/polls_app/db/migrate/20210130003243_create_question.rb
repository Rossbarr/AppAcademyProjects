class CreateQuestion < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.integer(:poll_id, { null: false })
      t.text(:text, { null: false } )

      t.timestamps
    end

    add_foreign_key(:questions, :polls, { column: :poll_id, primary_key: :id })
  end
end
