module Types
  module ObjectTypes
    module PlayerTypes
      class PlayerFilterType < BaseInputObject
        argument :username_contains, String, required: false, description: "Filter by username"
        argument :previous_name_contains, String, required: false, description: "Filter by previous names"
        argument :username_or_previous_name_contains, String, required: false, description: "Filter by either username or previous name"
      end
    end
  end
end
