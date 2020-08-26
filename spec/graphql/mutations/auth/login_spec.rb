require 'rails_helper'

RSpec.describe Mutations::AuthMutations::Login, type: :request do

  before(:all) do
    @temp = User.create({username: 'temp', password: "123456"})
  end

  describe "Authentication system" do
    it "logs in with valid credentials" do
      post $graphql_url, params: login_query("temp", "123456")
      json_response = JSON.parse(@response.body)
      expect(json_response).to_not be_nil
      expect(json_response["data"]).to_not be_nil
      expect(json_response["data"]["login"]).to_not be_nil
      expect(json_response["data"]["login"]["token"]).to_not be_nil
      expect(json_response["data"]["login"]["user"]).to_not be_nil
      expect(json_response["data"]["login"]["user"]["id"].to_i).to eq(@temp.id.to_i)
      expect(json_response["data"]["login"]["user"]["resetPassword"]).to eq(@temp.reset_password)
      expect(json_response["data"]["login"]["user"]["username"]).to eq(@temp.username)
    end

    it "doesn't login with invalid credentials" do
      post $graphql_url, params: login_query("temp", "1234567")
      json_response = JSON.parse(@response.body)
      expect(json_response).to_not be_nil
      expect(json_response["data"]).to_not be_nil
      expect(json_response["data"]["login"]).to be_nil
      expect(json_response["errors"]).to_not be_nil
    end
  end
end