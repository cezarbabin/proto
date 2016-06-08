# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


User.new(first:  "Example",
             last: "User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             activated: true,
             activated_at: Time.zone.now).save(validate: false)

99.times do |n|
  first  = Faker::Name.name
  last   = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.new(first:  first,
               last: last,
               email: email,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now).save(validate: false)
end