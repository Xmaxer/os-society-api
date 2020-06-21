module Types
    module PlayerTypes
      class PlayerOrderType < BaseInputObject
        argument :order_by, Types::PlayerTypes::PlayerOrderEnumType, required: false, description: "What to order the results by"
        argument :order, Types::GeneralTypes::OrderEnumType, required: false, description: "Direction to order results by"
      end
    end
end
