class ChangeTypesColumnToHowRecordedInAlbums < ActiveRecord::Migration[5.2]
  def change
    remove_column(:albums, :year)
    remove_column(:albums, :type)
    add_column(:albums, :year, :date, null: false)
    add_column(:albums, :how_recorded, :string, null: false)
  end
end
