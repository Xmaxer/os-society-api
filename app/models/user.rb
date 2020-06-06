class User < ApplicationRecord
  has_secure_password

  attr_accessor :current_token
  before_create :create_secret_key

  validates :username, length: {in: 1..20, too_long: Constants::Errors::USER_USERNAME_TOO_LONG_ERROR[:message], too_short: Constants::Errors::USER_USERNAME_TOO_SHORT_ERROR[:message]}, presence: {message: Constants::Errors::USER_USERNAME_NOT_PRESENT_ERROR[:message]}, format: {with: /\A([a-zA-Z0-9\-_]+\s)*[a-zA-Z0-9\-_]+\Z/i, message: Constants::Errors::USER_USERNAME_NOT_VALID_ERROR[:message]}, uniqueness: {message: Constants::Errors::USER_USERNAME_ALREADY_EXISTS_ERROR[:message]}
  validates :password, length: {in: 6..30, too_long: Constants::Errors::USER_PASSWORD_TOO_LONG_ERROR[:message], too_short: Constants::Errors::USER_PASSWORD_TOO_SHORT_ERROR[:message]}, presence: {message: Constants::Errors::USER_PASSWORD_NOT_PRESENT_ERROR[:message]}


  def get_user_secret_key
    self.secret_key
  end

  def change_secret_key
    self.update_attribute(:secret_key, SecureRandom.hex(64))
  end

  def create_secret_key
    self.secret_key = SecureRandom.hex(64)
  end

end
