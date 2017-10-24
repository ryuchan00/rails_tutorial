# User.create(id: 1, name: "Michael Hartl", email: "michael@example.com", password: "foobar", password_confirmation: "foobar")
# require 'faker/okinawa'

# ユーザー
User.create!(name: "ExampleUser",
             email: "example@railstutorial.org",
             password: "foobar",
             password_confirmation: "foobar",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

99.times do |n|
  name = Faker::Name.unique.name
  name = name.gsub(" ", "")
  name = name.gsub(".", "")
  name = name.gsub("'", "")
  # name = Faker::Okinawa::Name.last_name
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
# users = User.order(:created_at).take(1)
# 4950.times do
#   content = Faker::Okinawa::Address.city + "出身\n" + \
#   Faker::Okinawa::Address.district + "在住\n" + \
#   Faker::Okinawa::Awamori.name + " と " + Faker::Okinawa::Awamori.name + " が好き"
#   users.each { |user| user.microposts.create!(content: content) }
# end

users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(5)
  # content = Faker::Okinawa::Awamori.name + " と " + Faker::Okinawa::Awamori.name + " が好き"
  users.each { |user| user.microposts.create!(content: content) }
end

user = User.find(2)
10.times do
  content = "@ExampleUser " + Faker::Lorem.sentence(5)
  user.microposts.create(content: content, in_reply_to: 1)
end

# リレーションシップ
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
