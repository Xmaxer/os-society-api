module Types
  class QueryType < Types::BaseObject
    field :isAuthenticated, resolver: Resolvers::AuthResolvers::Authenticated
    field :players, resolver: Resolvers::PlayerResolvers::Players
    field :totalPlayers, resolver: Resolvers::PlayerResolvers::PlayersCount
  end
end
