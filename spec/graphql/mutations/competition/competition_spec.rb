require 'rails_helper'

RSpec.describe Mutations::CompetitionMutations, type: :request do

  before(:each) do
    allow_any_instance_of(GraphqlController).to receive(:current_user).and_return($user)
  end

  describe "when creating a competition" do

    it "can create a new competition" do
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

  describe "when updating a competition" do

    it "can update an existent competition" do
      external_url = "http://place.com"
      external_url2 = "http://place2.com"
      competition = Competition.create!(external_url: external_url)
      post $graphql_url, params: update_competition_mutation(external_url2, competition.id)
      json_response = JSON.parse(@response.body)
      competition_result = json_response["data"]["updateCompetition"]["competition"]
      expect(competition_result["externalUrl"]).to eq(external_url2)
      expect(competition_result["id"]).to eq(competition.id.to_s)
      expect(competition_result["competitionRecords"]).to eq([])
    end

    it "cannot update/create a non existent competition" do
      external_url = "http://place.com"
      post $graphql_url, params: update_competition_mutation(external_url, 500)
      json_response = JSON.parse(@response.body)
      competition_result = json_response["data"]["updateCompetition"]
      expect(competition_result).to be_nil
      expect(json_response["errors"]).to_not be_nil
    end

  end

  describe "when deleting a competition" do

    it "can delete an existent competition" do
      external_url = "http://place.com"
      competition = Competition.create!(external_url: external_url)
      post $graphql_url, params: delete_competition_mutation(competition.id)
      json_response = JSON.parse(@response.body)
      competition_result = json_response["data"]["deleteCompetition"]["competition"]
      expect(competition_result["externalUrl"]).to eq(competition.external_url)
      expect(competition_result["id"]).to eq(competition.id.to_s)
      expect(competition_result["competitionRecords"]).to eq([])
      expect(Competition.find_by(id: competition.id)).to be_nil
    end

    it "cannot delete a non existent competition" do
      post $graphql_url, params: delete_competition_mutation(500)
      json_response = JSON.parse(@response.body)
      competition_result = json_response["data"]["deleteCompetition"]
      expect(competition_result).to be_nil
      expect(json_response["errors"]).to_not be_nil
    end

  end

end