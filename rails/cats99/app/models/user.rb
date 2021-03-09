class User < ApplicationRecord
  has_secure_password

  validates :username, presence: true, uniqueness: true
  validates :session_token, presence: true

  after_initialize :ensure_session_token

  def self.find_by_credentials(username, password)
    User.find_by(username: username)&.authenticate(password)
  end

  def self.generate_session_token
    SecureRandom.urlsafe_base64
  end

  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end

  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save
  end
end
