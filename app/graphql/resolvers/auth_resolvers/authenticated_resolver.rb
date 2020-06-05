module Resolvers
  module AuthResolvers
    class AuthenticatedResolver < Resolvers::BaseResolver

      description "Checks whether the login you're authenticated or not"

      type Boolean, null: false

      def resolve
        !context[:current_user].nil?
      end
    end
  end
end
