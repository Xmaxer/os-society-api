module Mutations
  module PlayerMutations
    class UpdatePlayer < Mutations::BaseMutationAuthenticated
      field :player, Types::PlayerTypes::PlayerType, null: true

      argument :id, ID, required: true
      argument :attributes, Types::PlayerTypes::PlayerInput, required: true

      def resolve(attributes:, id:)
        player = Player.find_by(id: id)

        if player.update_attributes(attributes.to_h)
          {player: player}
        else
          model_errors(player)
          nil
        end
      end
    end
  end
end