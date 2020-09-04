module Resolvers
  module PayoutResolvers
    class PayoutsResolver < Resolvers::BaseResolverAuthenticated

      require 'search_object'
      require 'search_object/plugin/graphql'
      include SearchObject.module(:graphql)

      def initialize(**args)
        raise Exceptions::ExceptionHandler.to_graphql_execution_error(Constants::Errors::NOT_AUTHENTICATED_ERROR) unless args[:context][:current_user]
        super(args)
      end

      scope do
        object.payouts
      end

      option :filter, type: Types::PayoutTypes::PayoutFilterType, with: :apply_filter
      option :order, type: Types::PayoutTypes::PayoutOrderType, default: {order_by: "CREATED_AT", order: "DESC"}, with: :apply_order
      option :first, type: Int, default: 100, with: :apply_first
      option :skip, type: Int, default: 0, with: :apply_skip

      description "Returns a list of payouts"

      type [Types::PayoutTypes::PayoutType], null: true

      def apply_order(scope, value)
        scope = scope.order(value[:order_by].downcase.to_sym => value[:order].downcase.to_sym) if !value[:order].nil? and !value[:order_by].nil?
        scope
      end

      def apply_filter(scope, value)
        scope = scope.where('amount >= ?', value[:start_amount]) if value[:start_amount]
        scope = scope.where('amount <= ?', value[:end_amount]) if value[:end_amount]
        scope
      end

      def apply_first(scope, value)
        scope.limit(if value < 1 or value > 100
                      100
                    else
                      value
                    end)
      end

      def apply_skip(scope, value)
        scope.offset(if value < 1
                       0
                     else
                       value
                     end)
      end
    end
  end
end
