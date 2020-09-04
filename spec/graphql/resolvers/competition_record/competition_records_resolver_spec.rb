RSpec.describe Resolvers::CompetitionRecordResolvers, type: :request do

  before(:each) do
    allow_any_instance_of(GraphqlController).to receive(:current_user).and_return($user)
  end

  describe "when retrieving competition records" do

    before(:each) do
      @competition = Competition.create!(external_url: "http://place.com")
      (1..10).each do |i|
        player = Player.create!(username: 'user ' + i.to_s, rank: 1, join_date: DateTime.now)
        CompetitionRecord.create!(competition: @competition, player: player, xp: 100 - i, position: i)
      end
    end

    it "can get a list of competition records belonging to a competition" do
      post $graphql_url, params: competition_records_query(competitionId: @competition.id)
      json_response = JSON.parse(@response.body)
      competitions = json_response["data"]["competitionRecords"]
      expect(competitions.size).to eq(3)
    end

    it "can get a list of competition records when empty" do
      CompetitionRecord.destroy_all
      post $graphql_url, params: competition_records_query(competitionId: @competition.id)
      json_response = JSON.parse(@response.body)
      competitions = json_response["data"]["competitionRecords"]
      expect(competitions.size).to eq(0)
    end

    it "can get a specified number of competition records per page" do
      post $graphql_url, params: competition_records_query(competitionId: @competition.id, first: 5), as: :json
      json_response = JSON.parse(@response.body)
      competitions = json_response["data"]["competitionRecords"]
      expect(competitions.size).to eq(5)
    end

    it "can filter by position" do
      post $graphql_url, params: competition_records_query(competitionId: @competition.id, first: 10, startPosition: 3, endPosition: 7), as: :json
      json_response = JSON.parse(@response.body)
      competitions = json_response["data"]["competitionRecords"]
      expect(competitions.size).to eq(5)
    end

    it "can filter by xp" do
      post $graphql_url, params: competition_records_query(competitionId: @competition.id, first: 10, startXp: 95, endXp: 98), as: :json
      json_response = JSON.parse(@response.body)
      competitions = json_response["data"]["competitionRecords"]
      expect(competitions.size).to eq(4)
    end

    it "can filter by xp and position" do
      post $graphql_url, params: competition_records_query(competitionId: @competition.id, first: 10, startXp: 93, endXp: 98, startPosition: 1, endPosition: 4), as: :json
      json_response = JSON.parse(@response.body)
      competitions = json_response["data"]["competitionRecords"]
      expect(competitions.size).to eq(3)
    end

    it "can order by xp" do
      post $graphql_url, params: competition_records_query(competitionId: @competition.id, first: 10, orderBy: 'XP', order: 'ASC'), as: :json
      json_response = JSON.parse(@response.body)
      competitions = json_response["data"]["competitionRecords"]
      competitions.each_with_index do |competition_record, index|
        expect(competitions[index]["xp"].to_i).to be < competitions[index + 1]["xp"].to_i if index < competitions.size - 1
      end
      post $graphql_url, params: competition_records_query(competitionId: @competition.id, first: 10, orderBy: 'XP', order: 'DESC'), as: :json
      json_response = JSON.parse(@response.body)
      competitions = json_response["data"]["competitionRecords"]
      competitions.each_with_index do |competition_record, index|
        expect(competitions[index]["xp"].to_i).to be > competitions[index + 1]["xp"].to_i if index < competitions.size - 1
      end
    end

    it "can order by position" do
      post $graphql_url, params: competition_records_query(competitionId: @competition.id, first: 10, orderBy: 'POSITION', order: 'ASC'), as: :json
      json_response = JSON.parse(@response.body)
      competitions = json_response["data"]["competitionRecords"]
      competitions.each_with_index do |competition_record, index|
        expect(competitions[index]["position"].to_i).to be < competitions[index + 1]["position"].to_i if index < competitions.size - 1
      end
      post $graphql_url, params: competition_records_query(competitionId: @competition.id, first: 10, orderBy: 'POSITION', order: 'DESC'), as: :json
      json_response = JSON.parse(@response.body)
      competitions = json_response["data"]["competitionRecords"]
      competitions.each_with_index do |competition_record, index|
        expect(competitions[index]["position"].to_i).to be > competitions[index + 1]["position"].to_i if index < competitions.size - 1
      end
    end

  end
end
