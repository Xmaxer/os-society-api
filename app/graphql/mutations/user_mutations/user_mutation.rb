module Mutations
  module UserMutations
    class UserMutation < BaseMutationAuthenticated

      description "Creates or edits the specified player entry"

      argument :user_details, Types::ObjectTypes::UserTypes::EditUserArgumentType, required: true, description: "Valid user arguments"

      field :user, Types::ObjectTypes::UserTypes::UserType, null: true, description: "User data"

      def resolve(user_details:)

        id = user_details[:id]
        raise Exceptions::ExceptionHandler.to_graphql_execution_error(Constants::Errors::USER_CANNOT_EDIT_ANOTHER_ERROR) if id.to_s != context[:current_user].id.to_s

        user = User.find_by(id: id, reset_password: true)

        raise Exceptions::ExceptionHandler.to_graphql_execution_error(Constants::Errors::USER_DOES_NOT_EXIST_ERROR) if user.nil?

        user.assign_attributes({password: user_details[:password], reset_password: false})

        unless user.valid? && user.save
          Exceptions::ExceptionHandler.to_graphql_execution_error_array(user.errors).each { |error| context.add_error(error) }
          return {user: nil}
        end

        {user: user}
      end
    end
  end
end
