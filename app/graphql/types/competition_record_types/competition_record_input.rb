module Types
  module CompetitionRecordTypes
    class CompetitionRecordInput < BaseInputObject
      description "Arguments for editing or creating a new competition record."
      argument :xp, String, required: true, description: "The XP gained"
      argument :position, GraphQL::Types::BigInt, required: true, description: "The position of the player"
      argument :player, GraphQL::Types::BigInt, required: true, description: "The position of the player"
    end
  end
end
