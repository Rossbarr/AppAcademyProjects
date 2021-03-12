class User < ApplicationRecord
  validates(:email, presence: true, uniqueness: true)
  has_secure_password

  has_many(:session_tokens)
end
