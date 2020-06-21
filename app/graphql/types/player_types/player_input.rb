module Types
    module PlayerTypes
      class PlayerInput < BaseInputObject
        description "Arguments for editing or creating a new player."
        argument :username, String, required: true, description: "A valid username"
        argument :join_date, GraphQL::Types::ISO8601DateTime, required: true, description: "A valid non-future join date"
        argument :rank, Integer, required: true, description: "A valid rank number"
        argument :comment, String, required: false, description: "Optional extra comments"
        argument :previous_names, [String], required: false, description: "Any previous names this player had"
      end
  end
end
