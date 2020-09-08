RSpec.describe Resolvers::PlayerResolvers, type: :request do

  before(:each) do
    allow_any_instance_of(GraphqlController).to receive(:current_user).and_return($user)
  end

  describe "when retrieving players" do

    before(:each) do
      (1..10).each do |i|
        Player.create!(username: 'user ' + i.to_s, rank: i <= 7 ? i : 1, join_date: DateTime.now, previous_names: [10 - i])
      end
    end

    it "can get a list of players" do
      post $graphql_url, params: players_query
      json_response = JSON.parse(@response.body)
      players = json_response["data"]["players"]
      expect(players.size).to eq(10)
    end

    it "can get a list of players when empty" do
      Player.destroy_all
      post $graphql_url, params: players_query
      json_response = JSON.parse(@response.body)
      players = json_response["data"]["players"]
      expect(players.size).to eq(0)
    end

    it "can filter by username" do
      post $graphql_url, params: players_query(usernameContains: "1")
      json_response = JSON.parse(@response.body)
      players = json_response["data"]["players"]
      expect(players.size).to eq(2)
    end

    it "can filter by previous names" do
      post $graphql_url, params: players_query(previousNameContains: "1")
      json_response = JSON.parse(@response.body)
      players = json_response["data"]["players"]
      expect(players.size).to eq(1)
    end

    it "can filter by previous names or username" do
      post $graphql_url, params: players_query(usernameOrPreviousNameContains: "1")
      json_response = JSON.parse(@response.body)
      players = json_response["data"]["players"]
      expect(players.size).to eq(3)
    end

    it "can filter by rank" do
      post $graphql_url, params: players_query(rankContains: [1]), as: :json
      json_response = JSON.parse(@response.body)
      players = json_response["data"]["players"]
      expect(players.size).to eq(4)
    end

    it "can order by username" do
      post $graphql_url, params: players_query(orderBy: 'USERNAME', order: 'ASC'), as: :json
      json_response = JSON.parse(@response.body)
      players = json_response["data"]["players"]
      players.each_with_index do |player, index|
        expect(players[index]["username"].to_s).to be < players[index + 1]["username"].to_s if index < players.size - 1
      end
      post $graphql_url, params: players_query(orderBy: 'USERNAME', order: 'DESC'), as: :json
      json_response = JSON.parse(@response.body)
      players = json_response["data"]["players"]
      players.each_with_index do |player, index|
        expect(players[index]["username"].to_s).to be > players[index + 1]["username"].to_s if index < players.size - 1
      end
    end

    it "can order by id" do
      post $graphql_url, params: players_query(orderBy: 'ID', order: 'ASC'), as: :json
      json_response = JSON.parse(@response.body)
      players = json_response["data"]["players"]
      players.each_with_index do |player, index|
        expect(players[index]["id"].to_i).to be < players[index + 1]["id"].to_i if index < players.size - 1
      end
      post $graphql_url, params: players_query(orderBy: 'ID', order: 'DESC'), as: :json
      json_response = JSON.parse(@response.body)
      players = json_response["data"]["players"]
      players.each_with_index do |player, index|
        expect(players[index]["id"].to_i).to be > players[index + 1]["id"].to_i if index < players.size - 1
      end
    end

    it "can order by rank" do
      post $graphql_url, params: players_query(orderBy: 'RANK', order: 'ASC'), as: :json
      json_response = JSON.parse(@response.body)
      players = json_response["data"]["players"]
      players.each_with_index do |player, index|
        expect(players[index]["rank"].to_i).to be <= players[index + 1]["rank"].to_i if index < players.size - 1
      end
      post $graphql_url, params: players_query(orderBy: 'RANK', order: 'DESC'), as: :json
      json_response = JSON.parse(@response.body)
      players = json_response["data"]["players"]
      players.each_with_index do |player, index|
        expect(players[index]["rank"].to_i).to be >= players[index + 1]["rank"].to_i if index < players.size - 1
      end
    end

  end
end
