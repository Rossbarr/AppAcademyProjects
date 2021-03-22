class Track < ApplicationRecord
  validates(:title, presence: true)
  validates(:album_id, presence: true)
  validates(:ord, presence: true)
  validates(:is_regular, presence: true)

  belongs_to(:album)

  delegate(:band, to: :album)
end
