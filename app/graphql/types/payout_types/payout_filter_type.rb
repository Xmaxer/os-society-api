module Types
  module PayoutTypes
    class PayoutFilterType < BaseInputObject
      argument :start_amount, Integer, required: false, description: "Filter by starting amount"
      argument :end_amount, Integer, required: false, description: "Filter by end amount"
    end
  end
end
