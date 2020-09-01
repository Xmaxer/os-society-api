RSpec.describe Mutations::CompetitionRecordMutations, type: :request do

  before(:each) do
    allow_any_instance_of(GraphqlController).to receive(:current_user).and_return($user)
  end

  describe "when creating a competition record" do

    before(:each) do
      @player = Player.create!(username: "temp", rank: 1, join_date: DateTime.now)
      @player2 = Player.create!(username: "temp2", rank: 1, join_date: DateTime.now)
      @competition = Competition.create!(external_url: "http://place.com")
    end

    it "can create a new competition record" do
      xp = 100
      position = 1
      player_id = @player.id
      competition_id = @competition.id
      post $graphql_url, params: create_competition_record_mutation(xp, position, player_id, competition_id)
      json_response = JSON.parse(@response.body)
      competition_record = json_response["data"]["createCompetitionRecord"]["competitionRecord"]
      expect(competition_record["id"]).to_not be_nil
      expect(competition_record["position"]).to eq(position)
      expect(competition_record["xp"]).to eq(xp.to_s)
      expect(competition_record["player"]["id"]).to eq(@player.id.to_s)
      expect(competition_record["player"]["username"]).to eq(@player.username.to_s)
      expect(competition_record["payout"]).to be_nil
    end

    it "cannot create a duplicate competition records for the same position for the same competition" do
      xp = 100
      position = 1
      competition_id = @competition.id
      CompetitionRecord.create!(xp: xp, position: position, player_id: @player.id, competition_id: competition_id)
      post $graphql_url, params: create_competition_record_mutation(xp, position, @player2.id, competition_id)
      json_response = JSON.parse(@response.body)
      competition_record = json_response["data"]["createCompetitionRecord"]
      expect(competition_record).to be_nil
      expect(json_response["errors"]).to_not be_nil
    end

    it "cannot create a duplicate competition records for the same player for the same competition" do
      xp = 100
      player_id = @player.id
      competition_id = @competition.id
      CompetitionRecord.create!(xp: xp, position: 1, player_id: player_id, competition_id: competition_id)
      post $graphql_url, params: create_competition_record_mutation(xp, 2, player_id, competition_id)
      json_response = JSON.parse(@response.body)
      competition_record = json_response["data"]["createCompetitionRecord"]
      expect(competition_record).to be_nil
      expect(json_response["errors"]).to_not be_nil
    end
  end
  describe "when updating a competition record" do

    before(:each) do
      @player = Player.create!(username: "temp", rank: 1, join_date: DateTime.now)
      @player2 = Player.create!(username: "temp2", rank: 1, join_date: DateTime.now)
      @competition = Competition.create!(external_url: "http://place.com")
      @competition_record = CompetitionRecord.create!(competition: @competition, player: @player, position: 1, xp: 100000)
    end

    it "can update a competition record" do
      xp = 100
      position = 2
      player_id = @player.id
      competition_id = @competition.id
      post $graphql_url, params: update_competition_record_mutation(@competition_record.id, xp, position, player_id, competition_id)
      json_response = JSON.parse(@response.body)
      competition_record = json_response["data"]["updateCompetitionRecord"]["competitionRecord"]
      expect(competition_record["id"]).to_not be_nil
      expect(competition_record["position"]).to eq(position)
      expect(competition_record["xp"]).to eq(xp.to_s)
      expect(competition_record["player"]["id"]).to eq(@player.id.to_s)
      expect(competition_record["player"]["username"]).to eq(@player.username.to_s)
      expect(competition_record["payout"]).to be_nil
    end

    it "cannot update to an existent position for the competition" do
      xp = 1000
      competition_id = @competition.id
      player_id = @player2.id
      competition_record = CompetitionRecord.create!(xp: xp, position: 2, competition: @competition, player_id: player_id)
      post $graphql_url, params: update_competition_record_mutation(competition_record.id, xp, 1, player_id, competition_id)
      json_response = JSON.parse(@response.body)
      competition_record = json_response["data"]["updateCompetitionRecord"]
      expect(competition_record).to be_nil
      expect(json_response["errors"]).to_not be_nil
    end

    it "cannot update to an existent player for the competition" do
      xp = 1000
      competition_id = @competition.id
      position = 2
      competition_record = CompetitionRecord.create!(xp: xp, position: position, competition: @competition, player: @player2)
      post $graphql_url, params: update_competition_record_mutation(competition_record.id, xp, position, @player.id, competition_id)
      json_response = JSON.parse(@response.body)
      competition_record = json_response["data"]["updateCompetitionRecord"]
      expect(competition_record).to be_nil
      expect(json_response["errors"]).to_not be_nil
    end
  end

  describe "when deleting a competition record" do

    before(:each) do
      @player = Player.create!(username: "temp", rank: 1, join_date: DateTime.now)
      @player2 = Player.create!(username: "temp2", rank: 1, join_date: DateTime.now)
      @competition = Competition.create!(external_url: "http://place.com")
      @competition_record = CompetitionRecord.create!(competition: @competition, player: @player, position: 1, xp: 100000)
    end

    it "can delete a record" do
      expect(CompetitionRecord.find_by(id: @competition_record.id)).to_not be_nil
      post $graphql_url, params: delete_competition_record_mutation(@competition_record.id)
      json_response = JSON.parse(@response.body)
      competition_record = json_response["data"]["deleteCompetitionRecord"]["competitionRecord"]
      expect(competition_record["id"]).to_not be_nil
      expect(competition_record["position"]).to eq(@competition_record.position)
      expect(competition_record["xp"]).to eq(@competition_record.xp.to_s)
      expect(competition_record["player"]["id"]).to eq(@player.id.to_s)
      expect(competition_record["player"]["username"]).to eq(@player.username.to_s)
      expect(competition_record["payout"]).to be_nil
      expect(CompetitionRecord.find_by(id: @competition_record.id)).to be_nil
    end

    it "cannot delete a non existent record" do
      post $graphql_url, params: delete_competition_record_mutation(500)
      json_response = JSON.parse(@response.body)
      competition_record = json_response["data"]["deleteCompetitionRecord"]
      expect(competition_record).to be_nil
      expect(json_response["errors"]).to_not be_nil
    end
  end
end