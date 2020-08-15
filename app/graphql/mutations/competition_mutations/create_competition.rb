module Mutations
  module CompetitionMutations
    class CreateCompetition < Mutations::BaseMutationAuthenticated
      field :competition, Types::CompetitionTypes::CompetitionType, null: true

      argument :attributes, Types::CompetitionTypes::CompetitionInput, required: true

      def resolve(attributes:)
        competition = Competition.new(attributes.to_h)

        if competition.valid? && competition.save
          {competition: competition}
        else
          model_errors(competition)
          nil
        end
      end
    end
  end
end