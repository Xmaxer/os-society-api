class CompetitionRecord < ApplicationRecord
  belongs_to :player, optional: true
  belongs_to :competition

  validates :xp, numericality: {greater_than_or_equal_to: 0, only_integer: true}, allow_nil: false
  validates :position, numericality: {greater_than_or_equal_to: 1, only_integer: true}, allow_nil: false, uniqueness: {scope: :competition_id}
  validates :paid, allow_nil: false


end
