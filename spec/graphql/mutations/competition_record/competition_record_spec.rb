RSpec.describe Mutations::CompetitionMutations, type: :request do

  before(:each) do
    allow_any_instance_of(GraphqlController).to receive(:current_user).and_return($user)
  end

  describe "when creating a competition record" do

    it "can create a new competition record" do
      external_url = "http://place.com"
      post $graphql_url, params: create_competition_mutation(external_url)
      json_response = JSON.parse(@response.body)
      competition = json_response["data"]["createCompetition"]["competition"]
      expect(competition["externalUrl"]).to eq(external_url)
      expect(competition["id"]).to_not be_nil
      expect(competition["competitionRecords"]).to eq([])
    end

    it "can create a new competition without url" do
      external_url = nil
      post $graphql_url, params: create_competition_mutation(external_url)
      json_response = JSON.parse(@response.body)
      competition = json_response["data"]["createCompetition"]["competition"]
      expect(competition["externalUrl"]).to eq(external_url)
      expect(competition["id"]).to_not be_nil
      expect(competition["competitionRecords"]).to eq([])
    end

  end
end