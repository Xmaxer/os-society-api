module Types
  module CompetitionRecordTypes
    class CompetitionRecordType < BaseObject
      description "All the possible player data"
      field :id, ID, null: false, description: "The unique ID of the competition"
      field :xp, GraphQL::Types::BigInt, null: false, description: "The XP gained"
      field :player, Types::PlayerTypes::PlayerType, null: true, description: "The associated player"
    end
  end
end
