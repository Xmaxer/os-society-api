module Exceptions
  class ExceptionHandler
    class << self
      def to_graphql_execution_error(error)
        GraphQL::ExecutionError.new(error[:message], extensions: {code: error[:code]})
      end

      def to_graphql_execution_error_array(errors)
        exceptions = []
        errors.each do |attr, error|
          exceptions.push(GraphQL::ExecutionError.new(error, extensions: {code: -1, field: attr})) && next unless error.is_a?(Hash)
          error = error.to_h
          exceptions.push(GraphQL::ExecutionError.new(error[:message], extensions: {code: error[:code], field: attr}))
        end
        exceptions
      end
    end
  end
end