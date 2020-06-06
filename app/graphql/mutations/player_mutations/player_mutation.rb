module Mutations
  module PlayerMutations
    class PlayerMutation < BaseMutationAuthenticated

      description "Creates or edits the specified player entry"

      argument :player_details, Types::ObjectTypes::PlayerTypes::EditPlayerArgumentType, required: true, description: "Valid player arguments"

      field :player, Types::ObjectTypes::PlayerTypes::PlayerType, null: true, description: "Player data"

      def resolve(player_details:)

        id = player_details[:id]
        player = Player.find_or_initialize_by(id: id)

        if player.new_record?
          player.attributes = player_details.to_h.except(:id)
        else
          player.assign_attributes(player_details.to_h.except(:id))
        end

        unless player.valid? && player.save
          Exceptions::ExceptionHandler.to_graphql_execution_error_array(player.errors).each { |error| context.add_error(error) }
          return {player: nil}
        end

        {player: player}
      end
    end
  end
end
