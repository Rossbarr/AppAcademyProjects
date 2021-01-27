class CreateVisits < ActiveRecord::Migration[6.0]
  def change
    create_table :visits do |t|
      t.integer(:user_id,           { null: false })
      t.integer(:shortened_url_id,  { null: false })

      t.timestamps
    end

    add_foreign_key(:visits, :users,            { column: :user_id })
    add_foreign_key(:visits, :shortened_urls,   { column: :shortened_url_id })

    add_index(:visits, [:user_id, :shortened_url_id])
  end
end
