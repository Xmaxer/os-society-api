module Types
  module CompetitionRecordTypes
    class CompetitionRecordFilterType < BaseInputObject
      argument :start_position, Integer, required: false, description: "Filter by minimum position"
      argument :end_position, Integer, required: false, description: "Filter by maximum position"
      argument :start_xp, Integer, required: false, description: "Filter by minimum xp"
      argument :end_xp, Integer, required: false, description: "Filter by maximum xp"
    end
  end
end
