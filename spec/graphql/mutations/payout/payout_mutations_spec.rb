require 'rails_helper'

RSpec.describe Mutations::PayoutMutations, type: :request do

  before(:each) do
    allow_any_instance_of(GraphqlController).to receive(:current_user).and_return($user)
  end

  describe "when creating a payout" do

    before(:each) do
      @player = Player.create!(username: "temp", rank: 1, join_date: DateTime.now)
      @competition = Competition.create!(external_url: "http://place.com")
      @competition_record = CompetitionRecord.create!(xp: 100000, position: 1, player: @player, competition: @competition)
      @user2 = User.create!(username: "user2", password: "123456")
    end

    it "can create a new payout" do
      amount = 750000
      paid_by_id = $user.id
      competition_record_id = @competition_record.id
      post $graphql_url, params: create_payout_mutation(amount, paid_by_id, competition_record_id), as: :json
      json_response = JSON.parse(@response.body)
      payout = json_response["data"]["createPayout"]["payout"]
      expect(payout["amount"]).to eq(amount.to_s)
      expect(payout["id"]).to_not be_nil
      expect(payout["user"]["id"]).to eq($user.id.to_s)
    end

    it "can create a payout on behalf of another user" do
      amount = 750000
      paid_by_id = @user2.id
      competition_record_id = @competition_record.id
      post $graphql_url, params: create_payout_mutation(amount, paid_by_id, competition_record_id), as: :json
      json_response = JSON.parse(@response.body)
      payout = json_response["data"]["createPayout"]["payout"]
      expect(payout["amount"]).to eq(amount.to_s)
      expect(payout["id"]).to_not be_nil
      expect(payout["user"]["id"]).to eq(@user2.id.to_s)
    end

    it "cannot create duplicate payouts for the same payout record" do
      Payout.create!(amount: 500000, paid_by_id: $user.id, competition_record: @competition_record)
      amount = 750000
      paid_by_id = $user.id
      competition_record_id = @competition_record.id
      post $graphql_url, params: create_payout_mutation(amount, paid_by_id, competition_record_id), as: :json
      json_response = JSON.parse(@response.body)
      payout = json_response["data"]["createPayout"]
      expect(payout).to be_nil
      expect(json_response["errors"]).to_not be_nil
    end

  end

  describe "when updating a payout" do

    before(:each) do
      @player = Player.create!(username: "temp", rank: 1, join_date: DateTime.now)
      @competition = Competition.create!(external_url: "http://place.com")
      @competition_record = CompetitionRecord.create!(xp: 100000, position: 1, player: @player, competition: @competition)
      @user2 = User.create!(username: "user2", password: "123456")
      @payout = Payout.create!(amount: 500000, user: @user2, competition_record: @competition_record)
    end

    it "can update an existent payout" do
      amount = 750000
      paid_by_id = @user2.id
      competition_record_id = @competition_record.id
      post $graphql_url, params: update_payout_mutation(@payout.id, amount, paid_by_id, competition_record_id), as: :json
      json_response = JSON.parse(@response.body)
      payout = json_response["data"]["updatePayout"]["payout"]
      expect(payout["amount"]).to eq(amount.to_s)
      expect(payout["id"]).to_not be_nil
      expect(payout["user"]["id"]).to eq(@user2.id.to_s)
    end

    it "cannot update a non existent payout" do
      post $graphql_url, params: update_payout_mutation(500, 1000, @user2.id, @competition.id), as: :json
      json_response = JSON.parse(@response.body)
      payout = json_response["data"]["updatePayout"]
      expect(payout).to be_nil
      expect(json_response["errors"]).to_not be_nil
    end

  end

  describe "when deleting a payout" do

    before(:each) do
      @player = Player.create!(username: "temp", rank: 1, join_date: DateTime.now)
      @competition = Competition.create!(external_url: "http://place.com")
      @competition_record = CompetitionRecord.create!(competition: @competition, player: @player, position: 1, xp: 100000)
      @user2 = User.create!(username: "user2", password: "123456")
      @payout = Payout.create!(amount: 500000, user: @user2, competition_record: @competition_record)
    end

    it "can delete an existent payout" do
      expect(Payout.find_by(id: @payout.id)).to_not be_nil
      post $graphql_url, params: delete_payout_mutation(@payout.id)
      json_response = JSON.parse(@response.body)
      payout = json_response["data"]["deletePayout"]["payout"]
      expect(payout["id"]).to eq(@payout.id.to_s)
      expect(payout["amount"]).to eq(@payout.amount.to_s)
      expect(payout["user"]["id"]).to eq(@user2.id.to_s)
      expect(payout["user"]["username"]).to eq(@user2.username.to_s)
      expect(Payout.find_by(id: @payout.id)).to be_nil
    end

    it "cannot delete a non existent payout" do
      post $graphql_url, params: delete_payout_mutation(500)
      json_response = JSON.parse(@response.body)
      payout = json_response["data"]["deletePayout"]
      expect(payout).to be_nil
      expect(json_response["errors"]).to_not be_nil
    end

  end

end