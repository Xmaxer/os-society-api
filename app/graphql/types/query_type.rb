module Types
  class QueryType < Types::BaseObject
    field :is_authenticated, resolver: Resolvers::AuthResolvers::AuthenticatedResolver
    field :players, resolver: Resolvers::PlayerResolvers::PlayersResolver
  end
end
