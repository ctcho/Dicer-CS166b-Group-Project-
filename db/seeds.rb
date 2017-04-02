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
             address: "02453",
             admin: true)


25.times do |n|
  name = Faker::Name.name
  age = n + 1
  email = "example#{n+1}@example.com"
  password = "password"
  User.create!(username: name,
               email: email,
               password: password,
               password_confirmation: password,
               age: age,
               address: "415 South Street, Waltham, MA 02454")
end
