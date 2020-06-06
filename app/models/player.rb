class Player < ApplicationRecord
  before_save :default_values

  validate :validate_date, :check_previous_names

  validates :username, length: {in: 1..20, too_long: Constants::Errors::PLAYER_USERNAME_TOO_LONG_ERROR[:message], too_short: Constants::Errors::PLAYER_USERNAME_TOO_SHORT_ERROR[:message]}, presence: {message: Constants::Errors::PLAYER_USERNAME_NOT_PRESENT_ERROR[:message]}, format: {with: /\A([a-zA-Z0-9\-_]+\s)*[a-zA-Z0-9\-_]+\Z/i, message: Constants::Errors::PLAYER_USERNAME_NOT_VALID_ERROR[:message]}, uniqueness: {message: Constants::Errors::PLAYER_USERNAME_ALREADY_EXISTS_ERROR[:message]}
  validates :comment, length: {maximum: 200, too_long: Constants::Errors::PLAYER_COMMENT_TOO_LONG_ERROR[:message]}
  validates :rank, numericality: {only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 8, message: Constants::Errors::PLAYER_RANK_INVALID_ERROR[:message]}

  private

  def check_previous_names
    if previous_names.present? && !previous_names.nil? && previous_names.is_a?(Array)
      previous_names.each { |name|
        if name.size > 20 || name.blank? || (name =~ /\A([a-zA-Z0-9\-_]+\s)*[a-zA-Z0-9\-_]+\Z/i).nil?
          errors.add(:previous_names, Constants::Errors::PLAYER_PREVIOUS_NAME_INVALID[:message])
        end
      }
    end
  end

  def default_values
    self.previous_names = [] if self.previous_names.nil?
    self.removed = false if self.removed.nil?
  end

  def validate_date
    if join_date.present? && join_date > DateTime.now
      errors.add(:join_date, Constants::Errors::PLAYER_JOIN_DATE_IN_FUTURE_ERROR[:message])
    end
  end
end
