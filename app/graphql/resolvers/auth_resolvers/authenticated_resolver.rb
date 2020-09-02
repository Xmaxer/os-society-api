module Resolvers
  module AuthResolvers
    class AuthenticatedResolver < Resolvers::BaseResolver

      description "Checks whether the login you're authenticated or not"

      type Types::UserTypes::UserType, null: true

      def resolve
        context[:current_user]
      end
    end
  end
end
