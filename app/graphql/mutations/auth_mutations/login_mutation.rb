module Mutations
  module AuthMutations
    class LoginMutation < BaseMutation

      description "Login with valid credentials, returns a valid token if successful."

      argument :auth_details, Types::ObjectTypes::AuthTypes::AuthDetailsType, required: true, description: "Login Credentials"

      field :user, Types::ObjectTypes::UserTypes::UserType, null: false, description: "A valid token"
      field :token, String, null: false, description: "A valid token"

      def resolve(auth_details:)

        user = User.find_by(username: auth_details[:username])

        raise Exceptions::ExceptionHandler.to_graphql_execution_error(Constants::Errors::AUTHENTICATION_USERNAME_INVALID_ERROR) unless user
        raise Exceptions::ExceptionHandler.to_graphql_execution_error(Constants::Errors::AUTHENTICATION_PASSWORD_INVALID_ERROR) unless user.authenticate(auth_details[:password])

        {token: Authentication::Authentication.get_encoded_string(user), user: user}
      end
    end
  end
end
