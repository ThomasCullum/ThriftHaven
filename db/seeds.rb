# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Bid.destroy_all
Cart.destroy_all
Item.destroy_all
User.destroy_all


users << User.create!(
  email: "ypmzolisa@gmail.com",
  password: 'password',
  password_confirmation: 'password',
  first_name: "Prince",
  last_name: "Mzolisa",
  address: "21 Jump Street"
)


items = []
5.times do |i|
  items << Item.create!(
    name: "Item #{i}",
    category: "Category #{i}",
    description: "Description for item #{i}",
    price: (i+1) * 10,
    user: users.sample,
    rating: rand(0..10),
    sale_type: 0
  )
end

users.each do |user|
  2.times do
    Bid.create!(
      user: user,
      item: items.sample,
      amount: rand(10..100),
      status: 0
    )
  end
end

puts "Seeding completed!"
