require 'rails_helper'

RSpec.describe Mutations::AuthMutations::ResetPasswordMutation, type: :request do

  after(:all) do
    users = User.where("username like '%temp%'")
    users.destroy_all
  end

  describe "when trying to reset a password" do

    it "can reset password when true" do
      temp = User.create({username: 'temp', password: "123456"})
      token = Authentication::Authentication.get_encoded_string(temp)
      headers = {"Authorization": "Bearer " + token}
      post $graphql_url, params: reset_password_mutation(temp.id, "1234567"), headers: headers
      json_response = JSON.parse(@response.body)
      expect(json_response).to_not be_nil
      expect(json_response["data"]["updateUser"]["user"]["resetPassword"]).to be(false)
    end

    it "cannot reset password of another user" do
      temp = User.create({username: 'temp2', password: "123456"})
      post $graphql_url, params: reset_password_mutation(temp.id, "1234567"), headers: $headers
      json_response = JSON.parse(@response.body)
      expect(json_response).to_not be_nil
      expect(json_response["errors"]).to_not be_nil
    end

    it "cannot reset password when it's already reset" do
      temp = User.create({username: 'temp3', password: "123456", reset_password: false})
      token = Authentication::Authentication.get_encoded_string(temp)
      headers = {"Authorization": "Bearer " + token}
      post $graphql_url, params: reset_password_mutation(temp.id, "1234567"), headers: headers
      json_response = JSON.parse(@response.body)
      expect(json_response).to_not be_nil
      expect(json_response["errors"]).to_not be_nil
    end

  end
end