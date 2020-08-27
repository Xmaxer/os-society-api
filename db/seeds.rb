# Player creation
# root = Rails.root.to_s
#
# require 'csv'
#
# content = CSV.read("#{root}/db/seed_data/exported.csv")
# content.shift
# content.each do |row|
#   p row
#   username = row[0]
#   join_date = row[1].nil? || row[1].empty? ? DateTime.new(2016, 11, 27, 0, 0, 0) : DateTime.strptime(row[1], "%m/%d/%Y")
#   rank = row[2].to_s[0].to_i
#
#   if rank == 7
#     rank = 1
#   elsif rank >= 1 and rank <= 6
#     rank = rank + 1
#   end
#
#   comment = row[2].to_s
#
#   Player.find_or_create_by(username: username, join_date: join_date, rank: rank, comment: comment)
# end

if Rails.env == 'development'
  # Player creation
  players = []
  (1..200).each do |i|
    players.push(Player.find_or_create_by(username: "User " + i.to_s) do |player|
      player.rank = rand(0..8)
      player.join_date = Faker::Time.between(from: 4.years.ago, to: Date.today)
      player.comment = Faker::Lorem.sentence(word_count: rand(2..25))
      player.previous_names = Faker::Lorem.words(number: rand(0..5))
    end)
  end

  p "Total players: #{players.size}"
  # User creation
  user = User.find_or_create_by(username: 'xmax') do |user|
    user.password = '123456'
  end

  # Competition creation
  (1..20).each do |i|
    competition = Competition.create_or_find_by(external_url: "https://templeosrs.com/competitions/standings.php?id=2296")
    (1..3).each do |x|
      competition_record = CompetitionRecord.create_or_find_by(player: players[i * x], competition: competition) do |competition_record|
        competition_record.xp = Faker::Number.between(from: 1000, to: 10000000)
        competition_record.position = x
      end

      if rand(2) == 1
        Payout.find_or_create_by(competition_record: competition_record) do |payout|
          payout.amount = [250000, 500000, 1000000].sample
          payout.user = user
        end
      end
    end
  end
end