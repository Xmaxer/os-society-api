module Types
  module CompetitionRecordTypes
    class CompetitionRecordFilterType < BaseInputObject
      argument :start_position, Integer, required: false, description: "Filter by minimum position"
      argument :end_position, Integer, required: false, description: "Filter by maximum position"
    end
  end
end
