module Types
  module CompetitionRecordTypes
    class CompetitionRecordInput < BaseInputObject
      description "Arguments for editing or creating a new competition record."
      argument :xp, GraphQL::Types::BigInt, required: true, description: "The XP gained"
      argument :position, GraphQL::Types::BigInt, required: true, description: "The position of the player"
      argument :player_id, ID, required: true, description: "The associated player ID"
      argument :competition_id, ID, required: true, description: "The associated competition ID"
    end
  end
end
