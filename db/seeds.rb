# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

[
    "Serum",
    "Moisturizer",
    "Body Wash",
    "Night Cream",
    "Facial Cleanser"
].each do |category_name|
    Category.find_or_create_by!(name: category_name)
end

category = Category.find_by!(name: "Body Wash")

[
    {
        name: "Cinnamon Body Wash",
        description: "1 Liter for Dry and Sensitive Skin",
        category_id: category.id,
        quantity: Random.rand(20),
        price: 27.00
    },
    {
        name: "Coconut Oil Body Wash",
        description: "1 Liter for Dry and Sensitive Skin",
        category_id: category.id,
        quantity: Random.rand(20),
        price: 27.00
    },
    {
        name: "Green Tea Body Wash",
        description: "1 Liter for Dry and Sensitive Skin",
        category_id: category.id,
        quantity: Random.rand(20),
        price: 27.00
    },
    {
        name: "Jasmine Body Wash",
        description: "1 Liter for Dry and Sensitive Skin",
        category_id: category.id,
        quantity: Random.rand(20),
        price: 27.00
    },
    {
        name: "Mixed Berries Body Wash",
        description: "1 Liter for Dry and Sensitive Skin",
        category_id: category.id,
        quantity: Random.rand(20),
        price: 27.00
    },
    {
        name: "Pine and Sage Body Wash",
        description: "1 Liter for Dry and Sensitive Skin",
        category_id: category.id,
        quantity: Random.rand(20),
        price: 27.00
    },
    {
        name: "Tea Tree Body Wash",
        description: "1 Liter for Dry and Sensitive Skin",
        category_id: category.id,
        quantity: Random.rand(20),
        price: 27.00
    },
    {
        name: "Vanilla and Cinnamon Body Wash",
        description: "1 Liter for Dry and Sensitive Skin",
        category_id: category.id,
        quantity: Random.rand(20),
        price: 27.00
    },
].each do |product_properties|
    product = Product.new(product_properties)
    image_name = product_properties[:name].gsub(" ", "_").downcase + ".jpeg"
    product.image.attach(
        io: File.open(Rails.root.join("app/assets/images/products/#{image_name}")),
        filename: image_name
    )

    product.save
end
