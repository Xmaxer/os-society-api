RSpec.describe Resolvers::CompetitionResolvers, type: :request do

  before(:each) do
    allow_any_instance_of(GraphqlController).to receive(:current_user).and_return($user)
  end

  describe "when retrieving competitions" do

    before(:each) do
      (1..10).each do |i|
        Competition.create!(external_url: "http://place#{i}.com", created_at: (DateTime.now - i.seconds).to_datetime)
      end
    end

    it "can get a list of competitions" do
      post $graphql_url, params: competitions_query
      json_response = JSON.parse(@response.body)
      competitions = json_response["data"]["competitions"]
      expect(competitions.size).to eq(10)
    end

    it "can get a list of competitions when empty" do
      Competition.destroy_all
      post $graphql_url, params: competitions_query
      json_response = JSON.parse(@response.body)
      competitions = json_response["data"]["competitions"]
      expect(competitions.size).to eq(0)
    end

    it "can filter by external url" do
      post $graphql_url, params: competitions_query(externalUrlContains: '1')
      json_response = JSON.parse(@response.body)
      competitions = json_response["data"]["competitions"]
      expect(competitions.size).to eq(2)
      post $graphql_url, params: competitions_query(externalUrlContains: '2')
      json_response = JSON.parse(@response.body)
      competitions = json_response["data"]["competitions"]
      expect(competitions.size).to eq(1)
    end

    it "can order by created at" do
      post $graphql_url, params: competitions_query(orderBy: 'CREATED_AT', order: 'ASC')
      json_response = JSON.parse(@response.body)
      competitions = json_response["data"]["competitions"]
      competitions.each_with_index do |competition, index|
        expect(competitions[index]["createdAt"].to_datetime).to be < competitions[index + 1]["createdAt"].to_datetime if index < competitions.size - 1
      end
      post $graphql_url, params: competitions_query(orderBy: 'CREATED_AT', order: 'DESC')
      json_response = JSON.parse(@response.body)
      competitions = json_response["data"]["competitions"]
      competitions.each_with_index do |competition, index|
        expect(competitions[index]["createdAt"].to_datetime).to be > competitions[index + 1]["createdAt"].to_datetime if index < competitions.size - 1
      end
    end

  end
end
