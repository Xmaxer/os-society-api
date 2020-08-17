module Types
  module CompetitionRecordTypes
    class CompetitionRecordType < BaseObject
      description "All the possible payout data"
      field :id, ID, null: false, description: "The unique ID of the competition"
      field :xp, GraphQL::Types::BigInt, null: false, description: "The XP gained"
      field :player, Types::PlayerTypes::PlayerType, null: false, description: "The associated player"
      field :position, Integer, null: false, description: "The ranking within the competition"
    end
  end
end
