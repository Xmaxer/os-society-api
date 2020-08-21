module Types
  class QueryType < Types::BaseObject
    field :isAuthenticated, resolver: Resolvers::AuthResolvers::Authenticated
    field :players, resolver: Resolvers::PlayerResolvers::Players
    field :totalPlayers, resolver: Resolvers::PlayerResolvers::PlayersCount
    field :competitions, resolver: Resolvers::CompetitionResolvers::Competitions
    field :competition, resolver: Resolvers::CompetitionResolvers::Competition
  end
end
