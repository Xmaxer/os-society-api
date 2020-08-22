require 'rails_helper'

RSpec.describe Mutations::UserMutations::UpdateUser, type: :request do

  before(:all) do
    @user = User.create({username: 'test', password: "123456"})
  end

  describe "Authentication system" do
    it "logs in with valid credentials" do

    end
  end
end