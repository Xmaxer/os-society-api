class Payout < ApplicationRecord
  belongs_to :user, foreign_key: 'paid_by_id'
  belongs_to :competition_record
end
