module Types
  module CompetitionTypes
    class CompetitionType < BaseObject
      description "All the possible competition data"
      field :id, ID, null: false, description: "The unique ID of the competition"
      field :external_url, String, null: true, description: "The external competition URL"
      field :created_at, String, null: true, description: "The date time the competition was created at"
      field :competition_records, resolver: Resolvers::CompetitionRecordResolvers::CompetitionRecords
    end
  end
end
