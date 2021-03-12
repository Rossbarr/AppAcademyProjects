class SessionToken < ApplicationRecord
  has_secure_token(:session_token)

  validates(:user_id, presence: true)
  validates(:session_token, presence: true)

  belongs_to(:user)
end
