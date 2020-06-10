module Types
  module ObjectTypes
    module UserTypes
      class EditUserArgumentType < BaseInputObject
        description "Arguments for editing a User."
        argument :password, String, required: true, description: "A valid new password"
        argument :id, ID, required: true, description: "User ID to edit"
      end
    end
  end
end
