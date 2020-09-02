module Mutations
  module CompetitionMutations
    class DeleteCompetitionMutation < Mutations::BaseMutationAuthenticated
      field :competition, Types::CompetitionTypes::CompetitionType, null: true

      argument :id, ID, required: true

      def resolve(id:)
        competition = Competition.find_by(id: id)
        raise Exceptions::ExceptionHandler.to_graphql_execution_error(Constants::Errors::COMPETITION_DOES_NOT_EXIST_ERROR) if competition.nil?
        competition.destroy
        {competition: competition}
      end
    end
  end
end