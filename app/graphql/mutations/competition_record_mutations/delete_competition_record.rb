module Mutations
  module CompetitionRecordMutations
    class DeleteCompetitionRecord < Mutations::BaseMutationAuthenticated
      field :competition_record, Types::CompetitionRecordTypes::CompetitionRecordType, null: true

      argument :id, ID, required: true

      def resolve(id:)
        competition_record = CompetitionRecord.find_by(id: id)
        raise Exceptions::ExceptionHandler.to_graphql_execution_error(Constants::Errors::COMPETITION_RECORD_DOES_NOT_EXIST_ERROR) if competition_record.nil?
        competition_record.destroy
        {competition_record: competition_record}
      end
    end
  end
end