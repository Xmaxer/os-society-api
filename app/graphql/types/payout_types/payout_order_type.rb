module Types
  module PayoutTypes
    class PayoutOrderType < BaseInputObject
      argument :order_by, Types::PayoutTypes::PayoutOrderEnumType, required: false, description: "What to order the results by"
      argument :order, Types::GeneralTypes::OrderEnumType, required: false, description: "Direction to order results by"
    end
  end
end