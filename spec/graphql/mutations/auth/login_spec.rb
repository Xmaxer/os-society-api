require 'rails_helper'

RSpec.describe Mutations::AuthMutations::Login, type: :request do

  before(:all) do
    p "Running before"
    @user = User.create({username: 'test', password: "123456"})
  end

  describe "Authentication system" do
    it "logs in with valid credentials" do
      post '/api', params: login_query("test", "123456")
      json_response = JSON.parse(@response.body)
      p json_response
      expect(json_response).to_not be_nil
      expect(json_response["data"]).to_not be_nil
      expect(json_response["data"]["login"]).to_not be_nil
      expect(json_response["data"]["login"]["token"]).to_not be_nil
      expect(json_response["data"]["login"]["user"]).to_not be_nil
      expect(json_response["data"]["login"]["user"]["id"].to_i).to eq(@user.id.to_i)
      expect(json_response["data"]["login"]["user"]["resetPassword"]).to eq(@user.reset_password)
      expect(json_response["data"]["login"]["user"]["username"]).to eq(@user.username)
    end

    it "doesn't login with invalid credentials" do
      post '/api', params: login_query("test", "1234567")
      json_response = JSON.parse(@response.body)
      p json_response
      expect(json_response).to_not be_nil
      expect(json_response["data"]).to_not be_nil
      expect(json_response["data"]["login"]).to be_nil
      expect(json_response["errors"]).to_not be_nil
    end
  end
end