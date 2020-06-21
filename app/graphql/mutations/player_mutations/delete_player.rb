module Mutations
  module PlayerMutations
    class DeletePlayer < Mutations::BaseMutationAuthenticated
      field :player, Types::PlayerTypes::PlayerType, null: true

      argument :id, ID, required: true

      def resolve(id:)
        player = Player.find(id)
        raise Exceptions::ExceptionHandler.to_graphql_execution_error(Constants::Errors::PLAYER_DOES_NOT_EXIST_ERROR) if player.nil?
        player.destroy
        {player: player}
      end
    end
  end
end