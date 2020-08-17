module Types
  module PayoutTypes
    class PayoutInput < BaseInputObject
      description "Arguments for editing or creating a new payout."
      argument :amount, Integer, required: true, description: "The amount paid"
      argument :paid_by_id, ID, required: true, description: "The user that paid it"
      argument :competition_record_id, ID, required: true, description: "The associated competition record ID the payment is for"
    end
  end
end
