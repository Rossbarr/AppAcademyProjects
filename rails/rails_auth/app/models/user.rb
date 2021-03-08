class User < ApplicationRecord
  validates [:username, :session_token], presence: true, uniqueness: true
  validates :password_digest, presence: { message: "password can't be blank" }
  validates :password, length: { minimum: 8 allow_nil: true }

  before_validation :ensure_session_token

  def ensure_session_token
    @session_token ||= SecureRandom.urlsafe_base64
  end
end
