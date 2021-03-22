class ChangeIsRegularColumnOnTracks < ActiveRecord::Migration[5.2]
  def change
    remove_column(:tracks, :is_regular)
    add_column(:tracks, :is_bonus, :boolean, default: false, null: false)
  end
end
