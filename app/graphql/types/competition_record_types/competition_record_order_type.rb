module Types
  module CompetitionRecordTypes
    class CompetitionRecordOrderType < BaseInputObject
      argument :order_by, Types::CompetitionRecordTypes::CompetitionRecordOrderEnumType, required: false, description: "What to order the results by"
      argument :order, Types::GeneralTypes::OrderEnumType, required: false, description: "Direction to order results by"
    end
  end
end