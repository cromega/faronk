# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "Seeding DB"
Log.create!(
  user: "krom",
  channel: "dehat",
  message: "lofasz ez ugy ahogy van",
  sent_at: DateTime.now,
)
puts "done"

if ENV["LOREM_IPSUM"]
  require "faker"
  puts "Filling DB with lorem ipsum logs"

  100_000.times do |i|
    puts i if i % 5_000 == 0

    Log.create!(
      user: "user",
      channel: "dehat",
      message: Faker::Lorem.sentence,
      sent_at: DateTime.now,
    )
  end

  puts "done"
end

