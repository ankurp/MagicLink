class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true

  normalizes :email, with: -> { _1.downcase.strip }

  generates_token_for :password_reset, expires_in: 30.minutes do
    password_salt&.last(10)
  end

  generates_token_for :email_confirmation, expires_in: 30.minutes do
    email
  end
end
