RSpec.describe Resolvers::PayoutResolvers, type: :request do

  before(:each) do
    allow_any_instance_of(GraphqlController).to receive(:current_user).and_return($user)
  end

  describe "when retrieving payouts" do

    before(:each) do
      competition = Competition.create!(external_url: "http://place.com")
      player = Player.create!(username: 'user 1', rank: 1, join_date: DateTime.now)
      competition_record = CompetitionRecord.create!(competition: competition, player: player, xp: 100, position: 1)
      @payout = Payout.create!(amount: 500000, user: $user, competition_record: competition_record)
    end

    it "there are no tests" do
      # TODO
    end

  end
end
