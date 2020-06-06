User.create({username: 'xmax', password: '123456'})

(1..200).each do |i|
  Player.create({username: "User " + i.to_s, rank: rand(0..8), join_date: Faker::Time.between(from: 4.years.ago, to: Date.today), comment: Faker::Lorem.sentence(word_count: rand(2..25)), previous_names: Faker::Lorem.words(number: rand(0..5))})
end