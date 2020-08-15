module Mutations
  module CompetitionRecordMutations
    class UpdateCompetitionRecord < Mutations::BaseMutationAuthenticated
      field :competition, Types::CompetitionRecordTypes::CompetitionRecordType, null: true

      argument :id, ID, required: true
      argument :attributes, Types::CompetitionRecordTypes::CompetitionRecordInput, required: true

      def resolve(attributes:, id:)
        competition = competition.find_by(id: id)

        if competition.update_attributes(attributes.to_h)
          {competition: competition}
        else
          model_errors(competition)
          nil
        end
      end
    end
  end
end