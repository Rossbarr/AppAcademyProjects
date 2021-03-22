class Album < ApplicationRecord
  RECORDED_VALUES = ["studio", "live"]

  validates(:band_id, presence: true)
  validates(:name, presence: true)
  validates(:year, presence: true)
  validates(:how_recorded, presence: true, inclusion: RECORDED_VALUES)

  belongs_to(:band)

  has_many(:tracks)

  def sibling_albums
    self.band.albums
  end

  def num_tracks
    self.tracks.length
  end
end
