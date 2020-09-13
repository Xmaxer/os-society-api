module Mutations
  module PlayerMutations
    class CreatePlayerMutation < Mutations::BaseMutationAuthenticated
      field :player, Types::PlayerTypes::PlayerType, null: false

      argument :attributes, Types::PlayerTypes::PlayerInput, required: true

      def resolve(attributes:)
        player = Player.new(attributes.to_h)

        if player.valid? && player.save
          {player: player}
        else
          model_errors(player)
          nil
        end
      end
    end
  end
end