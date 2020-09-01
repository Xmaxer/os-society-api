module Mutations
  module PayoutMutations
    class UpdatePayout < Mutations::BaseMutationAuthenticated
      field :payout, Types::PayoutTypes::PayoutType, null: true

      argument :id, ID, required: true
      argument :attributes, Types::PayoutTypes::PayoutInput, required: true

      def resolve(attributes:, id:)
        payout = Payout.find_by(id: id)
        raise Exceptions::ExceptionHandler.to_graphql_execution_error(Constants::Errors::PAYOUT_DOES_NOT_EXIST_ERROR) if payout.nil?

        if payout.update(attributes.to_h)
          {payout: payout}
        else
          model_errors(payout)
          nil
        end
      end
    end
  end
end