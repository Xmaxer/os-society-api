module Mutations
  module PayoutMutations
    class DeletePayoutMutation < Mutations::BaseMutationAuthenticated
      field :payout, Types::PayoutTypes::PayoutType, null: false

      argument :id, ID, required: true

      def resolve(id:)
        payout = Payout.find_by(id: id)
        raise Exceptions::ExceptionHandler.to_graphql_execution_error(Constants::Errors::PAYOUT_DOES_NOT_EXIST_ERROR) if payout.nil?
        payout.destroy
        {payout: payout}
      end
    end
  end
end