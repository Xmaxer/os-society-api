module Mutations
  module CompetitionMutations
    class UpdateCompetition < Mutations::BaseMutationAuthenticated
      field :competition, Types::CompetitionTypes::CompetitionType, null: true

      argument :id, ID, required: true
      argument :attributes, Types::CompetitionTypes::CompetitionInput, required: true

      def resolve(attributes:, id:)
        competition = competition.find_by(id: id)

        if competition.update(attributes.to_h)
          {competition: competition}
        else
          model_errors(competition)
          nil
        end
      end
    end
  end
end