module Types
  module ObjectTypes
    module UserTypes
      class UserType < BaseObject
        description "All the possible user data"
        field :id, ID, null: false, description: "The unique ID of the user"
        field :username, String, null: false, description: "A valid username"
        field :reset_password, Boolean, null: false, description: "Whether the user needs a password reset or not"
      end
    end
  end
end
