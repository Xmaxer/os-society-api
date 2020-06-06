module Resolvers
  module PlayerResolvers
    class PlayersResolver < Resolvers::BaseResolverAuthenticated

      require 'search_object'
      require 'search_object/plugin/graphql'
      include SearchObject.module(:graphql)

      def initialize(**args)
        raise Exceptions::ExceptionHandler.to_graphql_execution_error(Constants::Errors::NOT_AUTHENTICATED_ERROR) unless args[:context][:current_user]
        super(args)
      end

      scope do
        players = Player.all
        context.scoped_context[:players] = players
        players
      end

      option :filter, type: Types::ObjectTypes::PlayerTypes::PlayerFilterType, with: :apply_filter
      option :order, type: Types::ObjectTypes::PlayerTypes::PlayerOrderType, default: {order_by: "CREATED_AT", order: "DESC"}, with: :apply_order
      option :first, type: Int, default: 100, with: :apply_first
      option :skip, type: Int, default: 0, with: :apply_skip

      description "Returns a list of players"

      type [Types::ObjectTypes::PlayerTypes::PlayerType], null: true

      def apply_order(scope, value)
        scope = scope.order(value[:order_by].downcase.to_sym => value[:order].downcase.to_sym) if !value[:order].nil? and !value[:order_by].nil?
        context.scoped_context[:players] = scope
        scope
      end

      def apply_filter(scope, value)
        scope = scope.where('lower(username) LIKE ?', "%#{value[:username_contains].downcase}%") if value[:username_contains]
        scope = scope.where('lower(array_to_string(previous_names, \',\')) LIKE ?', "%#{value[:previous_name_contains].downcase}%") if value[:previous_name_contains]
        scope = scope.where('lower(array_to_string(previous_names, \',\')) LIKE ? OR lower(username) LIKE ?', "%#{value[:username_or_previous_name_contains].downcase}%", "%#{value[:username_or_previous_name_contains].downcase}%") if value[:username_or_previous_name_contains]
        scope = scope.where(rank: value[:rank_contains]) if value[:rank_contains]
        context.scoped_context[:players] = scope
        scope
      end

      def apply_first(scope, value)
        scope.limit(if value < 1 or value > 300
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
