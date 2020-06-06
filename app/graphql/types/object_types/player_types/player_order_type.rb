module Types
  module ObjectTypes
    module PlayerTypes
      class PlayerOrderType < BaseInputObject
        argument :by, Types::ObjectTypes::PlayerTypes::PlayerOrderEnumType, required: true, description: "What to order the results by"
        argument :direction, Types::ObjectTypes::GeneralTypes::OrderEnumType, required: true, description: "Direction to order results by"
      end
    end
  end
end
