class AddIndexToAlbums < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key(:albums, :bands, column: :band_id, on_delete: :cascade)
  end
end
