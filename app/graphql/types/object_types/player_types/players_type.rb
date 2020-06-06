module Types
  module ObjectTypes
    module PlayerTypes
      class PlayersType < BaseObject
        description "All the possible player data"
        field :players, resolver: Resolvers::PlayerResolvers::PlayersResolver
        field :total_players, resolver: Resolvers::PlayerResolvers::PlayersCountResolver
      end
    end
  end
end
