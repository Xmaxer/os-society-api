module Types
  module ObjectTypes
    module PlayerTypes
      class EditPlayerArgumentType < BaseInputObject
        description "Arguments for editing or creating a new player."
        argument :username, String, required: false, description: "A valid username"
        argument :join_date, GraphQL::Types::ISO8601DateTime, required: false, description: "A valid non-future join date"
        argument :rank, Integer, required: false, description: "A valid rank number"
        argument :comment, String, required: false, description: "Optional extra comments"
        argument :previous_names, [String], required: false, description: "Any previous names this player had"
        argument :id, ID, required: false, description: "Optional player ID to edit"
      end
    end
  end
end
