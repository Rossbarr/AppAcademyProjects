class User < ApplicationRecord
  has_secure_password

  validates :username, presence: true, uniqueness: true
  validates :session_token, presence: true, uniqueness: true

  after_initialize :ensure_session_token

  has_many(:cats,
    class_name: "Cat",
    primary_key: :id,
    foreign_key: :user_id,
    dependent: :destroy
  )

  has_many(:received_requests,
    through: :cats,
    source: :requests
  )

  has_many(:submitted_requests,
    class_name: "RentalRequest",
    primary_key: :id,
    foreign_key: :user_id,
    dependent: :destroy
  )

  def self.find_by_credentials(username, password)
    User.find_by(username: username)&.authenticate(password)
  end

  def self.generate_session_token
    SecureRandom.urlsafe_base64
  end

  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save
  end

  private

  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end
end
