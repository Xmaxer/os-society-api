module Types
  module CompetitionTypes
    class CompetitionType < BaseObject
      description "All the possible player data"
      field :id, ID, null: false, description: "The unique ID of the competition"
      field :external_url, String, null: true, description: "The external competition URL"
    end
  end
end
