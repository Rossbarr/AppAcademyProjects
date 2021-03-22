class CreateTracks < ActiveRecord::Migration[5.2]
  def change
    create_table :tracks do |t|
      t.string(:title, null: false)
      t.integer(:album_id, null: false)
      t.integer(:ord, default: 0)
      t.text(:lyrics, default: nil)
      t.boolean(:is_regular, null: false, default: true)

      t.timestamps
    end

    add_foreign_key(:tracks, :albums, on_delete: :cascade)
    add_index(:tracks, [:album_id, :title])
  end
end
