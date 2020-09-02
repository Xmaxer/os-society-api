module Mutations
  module CompetitionRecordMutations
    class CreateCompetitionRecordMutation < Mutations::BaseMutationAuthenticated
      field :competition_record, Types::CompetitionRecordTypes::CompetitionRecordType, null: true

      argument :attributes, Types::CompetitionRecordTypes::CompetitionRecordInput, required: true

      def resolve(attributes:)
        competition_record = CompetitionRecord.new(attributes.to_h)

        if competition_record.valid? && competition_record.save
          {competition_record: competition_record}
        else
          model_errors(competition_record)
          nil
        end
      end
    end
  end
end