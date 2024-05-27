# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'faker'
p "deleting previous nonsense"
Item.delete_all
p "adding new things"

10.times do
  User.create(
    # first_name: Faker::ProgrammingLanguage.name,
    # last_name: Faker::ProgrammingLanguage.name ,
    # address: Faker::Address.full_address,
    email: "#{Faker::Vehicle.manufacture}@gmail.com",
    password: Faker::ProgrammingLanguage.name
  )
  p "user added"
end

20.times do
  Item.create(
    name: Faker::Vehicle.manufacture,
    category: ['Top', 'Bottom', 'Shoes', 'Accessories'].sample,
    description: Faker::TvShows::BigBangTheory.quote,
    rating: [1,2,3,4,5].sample,
    user_id: [1,2,3,4,5,6,7,8,9,10].sample
  )
  p "item added"
end

p "done"
