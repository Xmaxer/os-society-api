module Types
    module PlayerTypes
      class PlayersType < BaseObject
        description "All the possible player data"
        field :players, resolver: Resolvers::PlayerResolvers::Players
        field :total_players, resolver: Resolvers::PlayerResolvers::PlayersCount
      end
    end
end
