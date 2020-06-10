# User.create({username: 'xmax', password: '123456'})
#
# (1..200).each do |i|
#   Player.create({username: "User " + i.to_s, rank: rand(0..8), join_date: Faker::Time.between(from: 4.years.ago, to: Date.today), comment: Faker::Lorem.sentence(word_count: rand(2..25)), previous_names: Faker::Lorem.words(number: rand(0..5))})
# end
#
root = Rails.root.to_s

require 'csv'

content = CSV.read("#{root}/db/seed_data/exported.csv")
content.shift
content.each do |row|
  p row
  username = row[0]
  join_date = row[1].nil? || row[1].empty? ? DateTime.new(2016, 11, 27, 0, 0, 0) : DateTime.strptime(row[1], "%m/%d/%Y")
  rank = row[2].to_s[0].to_i

  if rank == 7
    rank = 1
  elsif rank >= 1 and rank <= 6
    rank = rank + 1
  end

  comment = row[2].to_s

  Player.create(username: username, join_date: join_date, rank: rank, comment: comment)
end