module Mutations
  module AuthMutations
    class ResetPasswordMutation < Mutations::BaseMutationAuthenticated
      field :user, Types::UserTypes::UserType, null: false

      argument :id, ID, required: true
      argument :attributes, Types::UserTypes::UserInput, required: true

      def resolve(attributes:, id:)

        raise Exceptions::ExceptionHandler.to_graphql_execution_error(Constants::Errors::USER_CANNOT_EDIT_ANOTHER_ERROR) if id != context[:current_user].id.to_s

        user = User.find_by(id: id, reset_password: true)
        raise Exceptions::ExceptionHandler.to_graphql_execution_error(Constants::Errors::USER_DOES_NOT_EXIST_ERROR) if user.nil?

        attributes = attributes.to_h
        attributes[:reset_password] = false
        if user.update(attributes.to_h)
          {user: user}
        else
          model_errors(user)
          nil
        end
      end
    end
  end
end