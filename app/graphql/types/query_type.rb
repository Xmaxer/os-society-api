module Types
  class QueryType < Types::BaseObject
    field :is_authenticated, resolver: Resolvers::AuthResolvers::AuthenticatedResolver
    field :players, resolver: Resolvers::PlayerResolvers::PlayersResolver
    field :total_players, resolver: Resolvers::PlayerResolvers::PlayersCountResolver
  end
end
