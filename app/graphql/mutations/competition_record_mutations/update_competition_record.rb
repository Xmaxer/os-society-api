module Mutations
  module CompetitionRecordMutations
    class UpdateCompetitionRecord < Mutations::BaseMutationAuthenticated
      field :competition_record, Types::CompetitionRecordTypes::CompetitionRecordType, null: true

      argument :id, ID, required: true
      argument :attributes, Types::CompetitionRecordTypes::CompetitionRecordInput, required: true

      def resolve(attributes:, id:)
        competition_record = CompetitionRecord.find_by(id: id)
        raise Exceptions::ExceptionHandler.to_graphql_execution_error(Constants::Errors::COMPETITION_RECORD_DOES_NOT_EXIST_ERROR) if competition_record.nil?

        if competition_record.update(attributes.to_h)
          {competition_record: competition_record}
        else
          model_errors(competition_record)
          nil
        end
      end
    end
  end
end