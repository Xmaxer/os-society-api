module Resolvers
  module PlayerResolvers
    class PlayersCount < Resolvers::BaseResolverAuthenticated

      description "Counts the total number of players"

      type Integer, null: false

      def resolve
        context.scoped_context[:players].nil? ? Player.count : context.scoped_context[:players].unscope(:limit, :offset).count
      end
    end
  end
end
