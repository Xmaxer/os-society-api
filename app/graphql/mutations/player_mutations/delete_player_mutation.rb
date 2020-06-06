module Mutations
  module PlayerMutations
    class DeletePlayerMutation < BaseMutationAuthenticated

      description "Permanently deletes a player record"

      argument :id, ID, required: true, description: "Valid player ID"

      field :player, Types::ObjectTypes::PlayerTypes::PlayerType, null: true, description: "Player data"

      def resolve(id:)

        player = Player.find_by(id: id)
        raise Exceptions::ExceptionHandler.to_graphql_execution_error(Constants::Errors::PLAYER_DOES_NOT_EXIST_ERROR) if player.nil?
        player.destroy
        {player: player}
      end
    end
  end
end
