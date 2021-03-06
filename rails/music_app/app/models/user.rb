class User < ApplicationRecord
  before_validation :lowercase_email

  validates(:email, presence: true, uniqueness: true)
  has_secure_password

  has_many(:session_tokens, dependent: :destroy)

  has_many(:notes, dependent: :destroy)

  def lowercase_email
    if self.email.respond_to?(:downcase)
      self.email = self.email.downcase
    end
  end

  def note_for(track)
    self.notes.find_by(id: track.id) || Note.new
  end
end
