class Note < ApplicationRecord
  validates(:user_id, presence: true)
  validates(:track_id, presence: true)
  validates(:note, presence: true)

  belongs_to(:user)

  belongs_to(:track)
end
