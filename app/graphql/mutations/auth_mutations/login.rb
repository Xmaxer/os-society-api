module Mutations
  module AuthMutations
    class Login < BaseMutation

      description "Login with valid credentials, returns a valid token if successful."

      argument :attributes, Types::AuthTypes::AuthInput, required: true, description: "Login Credentials"

      field :user, Types::UserTypes::UserType, null: false, description: "A valid user"
      field :token, String, null: false, description: "A valid token"

      def resolve(attributes:)

        user = User.find_by(username: attributes[:username])

        raise Exceptions::ExceptionHandler.to_graphql_execution_error(Constants::Errors::AUTHENTICATION_USERNAME_INVALID_ERROR) unless user
        raise Exceptions::ExceptionHandler.to_graphql_execution_error(Constants::Errors::AUTHENTICATION_PASSWORD_INVALID_ERROR) unless user.authenticate(attributes[:password])

        {token: Authentication::Authentication.get_encoded_string(user), user: user}
      end
    end
  end
end
