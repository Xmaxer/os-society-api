require 'rails_helper'

RSpec.describe Mutations::AuthMutations::Logout, type: :request do

  describe "when using the logout system" do

    it "can logout" do
      temp = User.create({username: 'temp', password: "123456"})
      token = Authentication::Authentication.get_encoded_string(temp)
      headers = {"Authorization": "Bearer " + token}
      auth_user = Authentication::Authentication.authenticate(token)
      expect(auth_user.id).to be(temp.id)
      post $graphql_url, params: logout_mutation, headers: headers
      json_response = JSON.parse(@response.body)
      expect(json_response["data"]["logout"]["success"]).to be(true)
      auth_user = Authentication::Authentication.authenticate(token)
      expect(auth_user).to be_nil
    end

  end
end