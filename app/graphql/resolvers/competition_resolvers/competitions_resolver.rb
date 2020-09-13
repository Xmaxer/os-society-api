module Resolvers
  module CompetitionResolvers
    class CompetitionsResolver < Resolvers::BaseResolverAuthenticated

      require 'search_object'
      require 'search_object/plugin/graphql'
      include SearchObject.module(:graphql)

      def initialize(**args)
        raise Exceptions::ExceptionHandler.to_graphql_execution_error(Constants::Errors::NOT_AUTHENTICATED_ERROR) unless args[:context][:current_user]
        super(args)
      end

      scope do
        Competition.all
      end

      option :filter, type: Types::CompetitionTypes::CompetitionFilterType, with: :apply_filter
      option :order, type: Types::CompetitionTypes::CompetitionOrderType, default: {order_by: "CREATED_AT", order: "DESC"}, with: :apply_order
      option :first, type: Int, default: 100, with: :apply_first
      option :skip, type: Int, default: 0, with: :apply_skip

      description "Returns a list of competitions"

      type [Types::CompetitionTypes::CompetitionType], null: false

      def apply_order(scope, value)
        scope = scope.order(value[:order_by].downcase.to_sym => value[:order].downcase.to_sym) if !value[:order].nil? and !value[:order_by].nil?
        scope
      end

      def apply_filter(scope, value)
        scope = scope.where('lower(external_url) LIKE ?', "%#{value[:external_url_contains].downcase}%") if value[:external_url_contains]
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
