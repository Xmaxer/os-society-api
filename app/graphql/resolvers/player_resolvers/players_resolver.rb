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

      scope { Player.all }

      option :filter, type: Types::ObjectTypes::PlayerTypes::PlayerFilterType, with: :apply_filter
      option :order, type: Types::ObjectTypes::PlayerTypes::PlayerOrderType, default: {by: "CREATED_AT", direction: "DESC"}, with: :apply_order
      option :first, type: Int, default: 10, with: :apply_first
      option :skip, type: Int, default: 0, with: :apply_skip

      description "Returns a list of players"

      type [Types::ObjectTypes::PlayerTypes::PlayerType], null: true

      def apply_order(scope, value)
        scope.order(value[:by].downcase.to_sym => value[:direction].downcase.to_sym)
      end

      def apply_filter(scope, value)
        scope = scope.where('lower(username) LIKE ?', "%#{value[:username_contains].downcase}%") if value[:username_contains]
        scope = scope.where('lower(array_to_string(previous_names, \',\')) LIKE ?', "%#{value[:previous_name_contains].downcase}%") if value[:previous_name_contains]
        scope = scope.where('lower(array_to_string(previous_names, \',\')) LIKE ? OR lower(username) LIKE ?', "%#{value[:username_or_previous_name_contains].downcase}%", "%#{value[:username_or_previous_name_contains].downcase}%") if value[:username_or_previous_name_contains]
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
