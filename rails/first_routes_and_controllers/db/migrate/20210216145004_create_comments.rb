class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.integer(:commenter_id, null: false)
      t.integer(:artwork_id, null: false)
      t.text(:body, null: false)

      t.timestamps()
    end

    add_index(:comments, [:commenter_id, :artwork_id], unique: true)
    add_foreign_key(:comments, :users, {column: :commenter_id, on_delete: :cascade})
    add_foreign_key(:comments, :artworks, {column: :artwork_id, on_delete: :cascade})
  end
end
