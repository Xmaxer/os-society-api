module Resolvers
  module CompetitionResolvers
    class CompetitionResolver < Resolvers::BaseResolverAuthenticated

      description "Gets a specific competition object"

      argument :id, ID, required: true

      type Types::CompetitionTypes::CompetitionType, null: true

      def resolve(id:)
        Competition.find_by(id: id)
      end
    end
  end
end
