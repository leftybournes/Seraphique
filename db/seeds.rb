# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


puts "Seeding categories..."
require_relative "seeds/category_seed" unless Category.count > 0
puts "Done!"

puts "Seeding products..."
require_relative "seeds/product_seed" unless Product.count > 0
puts "Done!"

puts "Seeding users..."
require_relative "seeds/user_seed" unless User.count > 0
puts "Done!"

puts "Seeding reviews..."
require_relative "seeds/review_seed" unless Review.count > 0
puts "Done!"
