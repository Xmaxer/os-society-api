RSpec.describe Resolvers::CompetitionResolvers, type: :request do

  before(:each) do
    allow_any_instance_of(GraphqlController).to receive(:current_user).and_return($user)
  end

  describe "when retrieving competitions" do

    before(:each) do
      (1..10).each do |i|
        Competition.create!(external_url: "http://place.com")
      end
    end

    it "can get a list of competitions" do
      post $graphql_url, params: competitions_query
      json_response = JSON.parse(@response.body)
      competitions = json_response["data"]["competitions"]
      expect(competitions.size).to eq(10)
    end

  end
end
