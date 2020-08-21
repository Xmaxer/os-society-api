module Types
  module CompetitionTypes
    class CompetitionOrderType < BaseInputObject
      argument :order_by, Types::CompetitionTypes::CompetitionOrderEnumType, required: false, description: "What to order the results by"
      argument :order, Types::GeneralTypes::OrderEnumType, required: false, description: "Direction to order results by"
    end
  end
end