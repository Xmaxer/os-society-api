module Mutations
  module PayoutMutations
    class CreatePayoutMutation < Mutations::BaseMutationAuthenticated
      field :payout, Types::PayoutTypes::PayoutType, null: true

      argument :attributes, Types::PayoutTypes::PayoutInput, required: true

      def resolve(attributes:)
        payout = Payout.new(attributes.to_h)

        if payout.valid? && payout.save
          {payout: payout}
        else
          model_errors(payout)
          nil
        end
      end
    end
  end
end