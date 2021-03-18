class Album < ApplicationRecord
  RECORDED_VALUES = ["studio", "live"]

  validates(:band_id, presence: true)
  validates(:name, presence: true)
  validates(:year, presence: true)
  validates(:how_recorded, presence: true, inclusion: RECORDED_VALUES)

  belongs_to(:band)
end
