module Types
  module ObjectTypes
    module PlayerTypes
      class PlayerType < BaseObject
        description "All the possible player data"
        field :id, ID, null: false, description: "The unique ID of the player"
        field :username, String, null: false, description: "A valid username"
        field :join_date, GraphQL::Types::ISO8601DateTime, null: false, description: "A valid non-future join date"
        field :rank, Integer, null: false, description: "A valid rank number"
        field :comment, String, null: true, description: "Optional extra comments"
        field :previous_names, [String], null: true, description: "Any previous names this player had"
        field :created_at, GraphQL::Types::ISO8601DateTime, null: false, description: "The date this player record was created"
        field :updated_at, GraphQL::Types::ISO8601DateTime, null: false, description: "The date this player record was updated"
      end
    end
  end
end
