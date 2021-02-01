class CreatePolls < ActiveRecord::Migration[6.0]
  def change
    create_table :polls do |t|
      t.integer(:author_id, { null: false })
      t.string(:title, { null: false })

      t.timestamps
    end

    add_foreign_key(:polls, :users, { column: :author_id, primary_key: :id } )
  end
end
