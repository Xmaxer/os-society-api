module Resolvers
  module PayoutResolvers
    class Payout < Resolvers::BaseResolverAuthenticated

      description "Gets a specific payout for the competition record"

      type Types::PayoutTypes::PayoutType, null: true

      def resolve
        object.payout
      end
    end
  end
end
