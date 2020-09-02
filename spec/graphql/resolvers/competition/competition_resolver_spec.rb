RSpec.describe Resolvers::CompetitionResolvers, type: :request do

  before(:each) do
    allow_any_instance_of(GraphqlController).to receive(:current_user).and_return($user)
  end

  describe "when retrieving a competition" do

    before(:each) do
      @competition = Competition.create!(external_url: "http://place.com")
      (1..10).each do |i|
        CompetitionRecord.create!(position: i, xp: i, competition: @competition, player: Player.create!(username: "User " + i.to_s, rank: 1, join_date: DateTime.now))
      end
    end

    it "can get a competition" do
      post $graphql_url, params: competition_query(@competition.id)
      json_response = JSON.parse(@response.body)
      competition = json_response["data"]["competition"]
      expect(competition["id"]).to eq(@competition.id.to_s)
      expect(competition["externalUrl"]).to eq(@competition.external_url.to_s)
      expect(competition["competitionRecords"].size).to eq(3)
    end

    it "cannot retrieve an invalid competition" do
      post $graphql_url, params: competition_query(500)
      json_response = JSON.parse(@response.body)
      competition = json_response["data"]["competition"]
      expect(competition).to be_nil
    end

  end
end
