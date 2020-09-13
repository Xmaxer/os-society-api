module Mutations
  module PlayerMutations
    class UpdatePlayerMutation < Mutations::BaseMutationAuthenticated
      field :player, Types::PlayerTypes::PlayerType, null: false

      argument :id, ID, required: true
      argument :attributes, Types::PlayerTypes::PlayerInput, required: true

      def resolve(attributes:, id:)
        player = Player.find_by(id: id)
        raise Exceptions::ExceptionHandler.to_graphql_execution_error(Constants::Errors::PLAYER_DOES_NOT_EXIST_ERROR) if player.nil?

        if player.update(attributes.to_h)
          {player: player}
        else
          model_errors(player)
          nil
        end
      end
    end
  end
end