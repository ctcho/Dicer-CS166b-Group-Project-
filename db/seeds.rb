# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# Pretty Seed Users
# Bjorn
bjorn = User.create!(username:  "Thunderbear",
             email: "thunderbear@evexis.com",
             password:              "bearhammer",
             password_confirmation: "bearhammer",
             address: "415 South Street, Waltham, MA",
             max_distance: 40,
             age: 20,
             admin: true)

bjorn.player_profile = PlayerProfile.new(experience_level: 2,
  bio: "My name is Bjorn. I really like playing DnD with friends online. I like to play a ton of different kind of characters and telling new stories is my favorite part. All of my characters have some connection to bears",
  online_play: 1, homebrew: 1, original_ruleset: 0, advanced_ruleset: 0, pathfinder: 1, third: 0, three_point_five: 1,
  fourth: 1, fifth: 1, original_campaign: 1, module: 1)

bjorn.dm_profile = DmProfile.new(experience_level: 1,
bio: "I've never been a DM before, so I'm looking for people who know what they like in a DM or who have been a DM before who can give me some pointers. I'd really like to tell some cool stories with people, I just need to learn how",
online_play: 1, homebrew: 1, original_ruleset: 0, advanced_ruleset: 0, pathfinder: 1, third: 0, three_point_five: 1,
fourth: 1, fifth: 1, original_campaign: 1, module: 1)




#Tali
tali = User.create!(username:  "TaliVasNormandy",
             email: "tali@n7.com",
             password:              "n7a6SVN",
             password_confirmation: "n7a6SVN",
             address: "161 Essex Street, Salem, MA",
             age: 18,
             max_distance: 45,
             admin: false)

tali.player_profile = PlayerProfile.create(experience_level: 2,
bio: "I like playing steampunk environment campaigns, and my favorite way to play is actually online. It lets me meet a lot of new people",
online_play: 1, homebrew: 1, original_ruleset: 1, advanced_ruleset: 1, pathfinder: 1, third: 1, three_point_five: 1,
fourth: 1, fifth: 0, original_campaign: 1, module: 1)

# Liara
liara = User.create!(username:  "ShadowBroker",
             email: "liara@n7.com",
             password:              "IluvProtheans",
             password_confirmation: "IluvProtheans",
             address: "137 Warren Avenue, Plymouth, MA",
             age: 29,
             max_distance: 90,
             admin: false)

liara.player_profile = PlayerProfile.new(experience_level: 2,
bio: "I like games with lots of lore, exploration, and discovery. Mysterious past civilizations are a plus.",
online_play: 1, homebrew: 0, original_ruleset: 1, advanced_ruleset: 1, pathfinder: 1, third: 0, three_point_five: 1,
fourth: 0, fifth: 0, original_campaign: 1, module: 1)

liara.dm_profile = DmProfile.new(experience_level: 3,
bio: "I write campaigns with secrets, information is currency in my worlds. What do you have to trade?",
online_play: 1, homebrew: 1, original_ruleset: 1, advanced_ruleset: 1, pathfinder: 1, third: 0, three_point_five: 1,
fourth: 0, fifth: 0, original_campaign: 1, module: 1)



# Garrus
garrus = User.create(username:  "Archangel",
             email: "garrus@n7.com",
             password:              "calibrations",
             password_confirmation: "calibrations",
             address: "174 Liberty Street Concord MA",
             max_distance: 100,
             age: 30,
             admin: false)

garrus.player_profile = PlayerProfile.create(experience_level: 3,
  bio: "I like playing rogues and fighting corruption.",   online_play: 1, homebrew: 1,
  original_ruleset: 0, advanced_ruleset: 1, pathfinder: 1, third: 0, three_point_five: 1,
  fourth: 0, fifth: 1, original_campaign: 1, module: 0)

garrus.dm_profile = DmProfile.create(experience_level: 1,
  bio: "I'm new at leading, the campaigns I've led have mostly ended with everyone dying, but I try my best",
  online_play: 1, homebrew: 1, original_ruleset: 0, advanced_ruleset: 1, pathfinder: 1, third: 0, three_point_five: 1,
  fourth: 1, fifth: 1, original_campaign: 1, module: 0)

# Wrex
wrex = User.create(username: "Wrex",
            email: "wrex@n7.com",
            password: "tuchanka",
            password_confirmation: "tuchanka",
            address: "02453",
            max_distance: 150,
            age: 25,
            admin: false)
wrex.player_profile = PlayerProfile.create(experience_level: 4,
  bio: "Shepard", online_play: 1, homebrew: 1, original_ruleset: 1, advanced_ruleset: 1,
  pathfinder: 1, third: 0, three_point_five: 1,
  fourth: 1, fifth: 1, original_campaign: 1, module: 1)
wrex.dm_profile = DmProfile.create(experience_level: 4,
  bio: "I have led my people to prosperity, I can lead a simple game campaign.",
  online_play: 1, homebrew: 1, original_ruleset: 1, advanced_ruleset: 1,
  pathfinder: 1, third: 0, three_point_five: 1,
  fourth: 1, fifth: 1, original_campaign: 1, module: 1)

# FemShep
shepard = User.create(username: "Commander",
                email: "Shepard@n7.com",
                password: "spectre",
                password_confirmation: "spectre",
                address: "Boston, MA",
                max_distance: 55,
                age: 32,
                admin: true)
shepard.player_profile = PlayerProfile.create(experience_level: 4,
  bio: "My name is Commander Shepard and this is my favorite App on the Citadel",
  online_play: 1, homebrew: 1, original_ruleset: 1, advanced_ruleset: 1,
  pathfinder: 1, third: 1, three_point_five: 1,
  fourth: 1, fifth: 1, original_campaign: 1, module: 1)
shepard.dm_profile = DmProfile.create(experience_level: 4,
  bio: "I have led my team through a Reaper Base and we all came out alive. You will too if you follow my campaigns",
  online_play: 1, homebrew: 1, original_ruleset: 1, advanced_ruleset: 1,
  pathfinder: 1, third: 1, three_point_five: 1,
  fourth: 1, fifth: 1, original_campaign: 1, module: 1)



  #seeds an additional 25 regular users
  25.times do |n|
    username = Faker::Name.name
    age = n + 13
    email = "example#{n+1}@example.com"
    password = "password"
    u = User.create!(username: username,
                 email: email,
                 password: password,
                 password_confirmation: password,
                 age: age,
                 address: "415 South Street, Waltham, MA 02454",
                 max_distance: 30)
    u.player_profile = PlayerProfile.create(experience_level: rand(5), bio: Faker::Hacker.say_something_smart ,   online_play: rand(2),
      homebrew: rand(2),
      original_ruleset: rand(2),
      advanced_ruleset: rand(2),
      pathfinder: rand(2),
      third: rand(2),
      three_point_five: rand(2),
      fourth: rand(2),
      fifth: rand(2),
      original_campaign: rand(2),
      module: rand(2))
    u.dm_profile = DmProfile.create(experience_level: rand(5), bio: Faker::Hacker.say_something_smart,   online_play: rand(2),
      homebrew: rand(2),
      original_ruleset: rand(2),
      advanced_ruleset: rand(2),
      pathfinder: rand(2),
      third: rand(2),
      three_point_five: rand(2),
      fourth: rand(2),
      fifth: rand(2),
      original_campaign: rand(2),
      module: rand(2))
  end
