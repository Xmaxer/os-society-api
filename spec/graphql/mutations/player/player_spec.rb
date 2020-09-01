require 'rails_helper'

RSpec.describe Mutations::PlayerMutations, type: :request do

  before(:each) do
    allow_any_instance_of(GraphqlController).to receive(:current_user).and_return($user)
  end

  describe "when creating a player" do

    it "can create a new player" do
      username = "A player"
      join_date = DateTime.now
      rank = 1
      post $graphql_url, params: create_player_mutation(username, join_date, rank), as: :json
      json_response = JSON.parse(@response.body)
      player = json_response["data"]["createPlayer"]["player"]
      expect(player["username"]).to eq(username)
      expect(player["id"]).to_not be_nil
      expect(player["joinDate"]).to_not be_nil
      expect(player["rank"]).to eq(rank)
    end

    it "cannot create a player with a duplicate name" do
      Player.create!(username: "A pLayEr", join_date: DateTime.now, rank: 2)
      username = "A player"
      join_date = DateTime.now
      rank = 1
      post $graphql_url, params: create_player_mutation(username, join_date, rank), as: :json
      json_response = JSON.parse(@response.body)
      player = json_response["data"]["createPlayer"]
      expect(player).to be_nil
      expect(json_response["errors"]).to_not be_nil
    end

  end

  describe "when updating a player" do

    before(:each) do
      @player = Player.create!(username: "temp", rank: 1, join_date: DateTime.now)
    end

    it "can update an existent player" do
      rank = 2
      join_date = 10.days.ago
      username = "temp2"
      post $graphql_url, params: update_player_mutation(@player.id, username, join_date, rank), as: :json
      json_response = JSON.parse(@response.body)
      player = json_response["data"]["updatePlayer"]["player"]
      expect(player["username"]).to eq(username)
      expect(player["id"]).to eq(@player.id.to_s)
      expect(player["joinDate"]).to_not be_nil
      expect(player["rank"]).to eq(rank)
    end

    it "cannot update a non existent player" do
      rank = 2
      join_date = 10.days.ago
      username = "temp2"
      post $graphql_url, params: update_player_mutation(500, username, join_date, rank), as: :json
      json_response = JSON.parse(@response.body)
      player = json_response["data"]["updatePlayer"]
      expect(player).to be_nil
      expect(json_response["errors"]).to_not be_nil
    end

  end

  describe "when deleting a player" do

    before(:each) do
      @player = Player.create!(username: "temp", rank: 1, join_date: DateTime.now)
    end

    it "can delete an existent player" do
      expect(Player.find_by(id: @player.id)).to_not be_nil
      post $graphql_url, params: delete_player_mutation(@player.id)
      json_response = JSON.parse(@response.body)
      player = json_response["data"]["deletePlayer"]["player"]
      expect(player["username"]).to eq(@player.username)
      expect(player["id"]).to eq(@player.id.to_s)
      expect(player["joinDate"]).to_not be_nil
      expect(player["rank"]).to eq(@player.rank)
      expect(Player.find_by(id: @player.id)).to be_nil
    end

    it "cannot delete a non existent player" do
      post $graphql_url, params: delete_player_mutation(500)
      json_response = JSON.parse(@response.body)
      player = json_response["data"]["deletePlayer"]
      expect(player).to be_nil
      expect(json_response["errors"]).to_not be_nil
    end

  end

end