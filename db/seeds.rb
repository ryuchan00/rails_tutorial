# User.create(id: 1, name: "Michael Hartl", email: "michael@example.com", password: "foobar", password_confirmation: "foobar")
require 'faker/okinawa'

# ユーザー
User.create!(name: "Example User",
             email: "example@railstutorial.org",
             password: "foobar",
             password_confirmation: "foobar",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

99.times do |n|
  # name = Faker::Name.name
  name = Faker::Okinawa::Name.last_name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end

# Micropostsを生成
users = User.order(:created_at).take(1)
4950.times do
  content = Faker::Okinawa::Address.city + "出身\n" + \
  Faker::Okinawa::Address.district + "在住\n" + \
  Faker::Okinawa::Awamori.name + " と " + Faker::Okinawa::Awamori.name + " が好き"
  users.each { |user| user.microposts.create!(content: content) }
end

users = User.order(:created_at).take(6)
50.times do
  # content = Faker::Lorem.sentence(5)
  content = Faker::Okinawa::Awamori.name + " と " + Faker::Okinawa::Awamori.name + " が好き"
  users.each { |user| user.microposts.create!(content: content) }
end

# リレーションシップ
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
