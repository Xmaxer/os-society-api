module Resolvers
  module CompetitionRecordResolvers
    class CompetitionRecords < Resolvers::BaseResolverAuthenticated

      require 'search_object'
      require 'search_object/plugin/graphql'
      include SearchObject.module(:graphql)

      def initialize(**args)
        raise Exceptions::ExceptionHandler.to_graphql_execution_error(Constants::Errors::NOT_AUTHENTICATED_ERROR) unless args[:context][:current_user]
        super(**args)
      end

      scope do
        object ? object.competition_records : CompetitionRecords.all
      end

      option :filter, type: Types::CompetitionRecordTypes::CompetitionRecordFilterType, with: :apply_filter
      option :order, type: Types::CompetitionRecordTypes::CompetitionRecordOrderType, default: {order_by: "POSITION", order: "ASC"}, with: :apply_order
      option :first, type: Int, default: 3, with: :apply_first
      option :skip, type: Int, default: 0, with: :apply_skip
      option :competition_id, type: ID, with: :by_competition

      description "Returns a list of competition records belonging to the object"

      type [Types::CompetitionRecordTypes::CompetitionRecordType], null: true

      def by_competition(scope, value)
        if !object and value[:competition_id] then
          scope.where(competition_id: value[:competition_id])
        end
      end

      def apply_order(scope, value)
        scope = scope.order(value[:order_by].downcase.to_sym => value[:order].downcase.to_sym) if !value[:order].nil? and !value[:order_by].nil?
        scope
      end

      def apply_filter(scope, value)
        scope = scope.where('position < ?', value[:start_position]) if value[:start_position]
        scope = scope.where('position > ?', value[:end_position]) if value[:end_position]
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
