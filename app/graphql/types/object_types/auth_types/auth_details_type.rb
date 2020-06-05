module Types
  module ObjectTypes
    module AuthTypes
      class AuthDetailsType < BaseInputObject
        argument :username, String, required: true, description: "A valid email"
        argument :password, String, required: true, description: "The password for the email user"
      end
    end
  end
end
