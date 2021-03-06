class User < ApplicationRecord
  attr_reader :password

  validates :username, presence: true, uniqueness: true
  validates :session_token, presence: true
  validates :password_digest, presence: { message: "password can't be blank" }
  validates :password, length: { minimum: 8, allow_nil: true }

  before_validation :ensure_session_token

  def self.find_by_credentials(username, password)
    user = User.find_by( username: username )

    return nil if user.nil?

    user.is_password?(password) ? user : nil
  end

  def self.generate_session_token
    SecureRandom.urlsafe_base64
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end

  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save!
  end
end
