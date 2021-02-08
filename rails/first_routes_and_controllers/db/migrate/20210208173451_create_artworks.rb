class CreateArtworks < ActiveRecord::Migration[5.2]
  def change
    create_table :artworks do |t|
      t.string(:title, null: false)
      t.string(:image_url, null: false)
      t.integer(:artist_id, null: false)

      t.timestamps
    end

    add_foreign_key(:artworks, :users, {column: :artist_id, on_delete: :cascade})
  end
end
