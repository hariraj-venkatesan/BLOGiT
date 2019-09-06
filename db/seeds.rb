# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.destroy_all
Post.destroy_all

10.times do |n|
	name = Faker::Name.name
	email = "example-#{n+1}@email.com"
	password = "password"
	users = User.create(name: name,
				email: email,
				password: password,
				password_confirmation: password)
	# users = User.order(:created_at).take
	1.times do
		title = Faker::Lorem.sentence(5)
		content = Faker::Lorem.sentence(25)
		users.posts.create!(title: title, content: content, public_post: true)
		# users.each { |user| user.posts.create!(content: content, public_post: true) }
	end
	2.times do
		title = Faker::Lorem.sentence(5)
		content = Faker::Lorem.sentence(25)
		users.posts.create!(title: title, content: content, public_post: false)
		# users.each { |user| user.posts.create!(content: content, public_post: false) }
	end
end