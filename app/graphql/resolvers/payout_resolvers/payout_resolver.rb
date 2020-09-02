module Resolvers
  module PayoutResolvers
    class PayoutResolver < Resolvers::BaseResolverAuthenticated

      description "Gets a specific payout for the competition record"

      type Types::PayoutTypes::PayoutType, null: true

      def resolve
        object.payout
      end
    end
  end
end
