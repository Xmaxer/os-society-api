class Payout < ApplicationRecord
  belongs_to :user, foreign_key: 'paid_by_id'
  belongs_to :competition_record

  validates :amount, numericality: {greater_than_or_equal_to: 0}, allow_nil: true
end
