# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
email = "admin@example.com"
result_user = User.find_by(email: email)
if(result_user.blank?)
  user = User.create(email: email, name: "Admin", mobile_number: "984932919", password: "password")
  puts "User #{user.name} created with email #{user.email}"
end

require 'faker'

if (User.count < 20)
  20.times do
    User.create(name: Faker::Name.name, email: Faker::Internet.email, mobile_number: Faker::PhoneNumber.cell_phone, password: Faker::Code.nric)
  end
end