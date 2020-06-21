module Types
    module UserTypes
      class UserInput < BaseInputObject
        description "Arguments for editing a user"
        argument :password, String, required: true, description: "A valid new password"
      end
    end
end
