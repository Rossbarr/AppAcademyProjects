class User < ApplicationRecord
  before_validation :lowercase_email

  validates(:email, presence: true, uniqueness: true)
  has_secure_password

  has_many(:session_tokens)

  def lowercase_email
    self.email = self.email.downcase
  end
end
