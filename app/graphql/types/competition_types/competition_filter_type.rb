module Types
  module CompetitionTypes
    class CompetitionFilterType < BaseInputObject
      argument :external_url_contains, String, required: false, description: "Filter by what the external URL contains"
    end
  end
end
