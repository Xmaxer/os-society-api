module Mutations
  module CompetitionMutations
    class UpdateCompetition < Mutations::BaseMutationAuthenticated
      field :competition, Types::CompetitionTypes::CompetitionType, null: true

      argument :id, ID, required: true
      argument :attributes, Types::CompetitionTypes::CompetitionInput, required: true

      def resolve(attributes:, id:)
        competition = Competition.find_by(id: id)
        raise Exceptions::ExceptionHandler.to_graphql_execution_error(Constants::Errors::COMPETITION_DOES_NOT_EXIST_ERROR) if competition.nil?

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