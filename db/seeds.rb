# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#creates a seeded user with administrative powers
User.create!(username:  "Example User",
             email: "example@dicer.org",
             password:              "foobar",
             password_confirmation: "foobar",
             address: "New York City",
             admin: true)

#seeds an additional 25 regular users
25.times do |n|
  username = Faker::Name.name
  age = n + 1
  email = "example#{n+1}@example.com"
  password = "password"
  u = User.create!(username: username,
               email: email,
               password: password,
               password_confirmation: password,
               age: age,
               address: Faker::Address.state,
               max_distance: 50
               #address: "415 South Street, Waltham, MA 02454")
               )
  u.player_profile = PlayerProfile.create(experience_level: 3, bio: "I have a bio",   online_play: 1,
    homebrew: 1,
    original_ruleset: 0,
    advanced_ruleset: 1,
    pathfinder: 0,
    third: 0,
    three_point_five: 1,
    fourth: 1,
    fifth: 1,
    original_campaign: 1,
    module: 1)
end

# Create seeded private chats and messages.
