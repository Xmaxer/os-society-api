module Types
  class QueryType < Types::BaseObject
    field :isAuthenticated, resolver: Resolvers::AuthResolvers::AuthenticatedResolver
    field :players, resolver: Resolvers::PlayerResolvers::PlayersResolver
    field :totalPlayers, resolver: Resolvers::PlayerResolvers::PlayersCountResolver
    field :competitions, resolver: Resolvers::CompetitionResolvers::CompetitionsResolver
    field :competition, resolver: Resolvers::CompetitionResolvers::CompetitionResolver
    field :competition_records, resolver: Resolvers::CompetitionRecordResolvers::CompetitionRecords
  end
end
