module Types
  module ObjectTypes
    module PlayerTypes
      class PlayerOrderType < BaseInputObject
        argument :by, Types::ObjectTypes::PlayerTypes::PlayerOrderEnumType, required: false, description: "What to order the results by"
        argument :direction, Types::ObjectTypes::GeneralTypes::OrderEnumType, required: false, description: "Direction to order results by"
      end
    end
  end
end
