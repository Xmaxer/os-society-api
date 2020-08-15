module Types
  module CompetitionTypes
    class CompetitionInput < BaseInputObject
      description "Arguments for editing or creating a new competition."
      argument :external_url, String, required: false, description: "A valid external URL"
    end
  end
end
