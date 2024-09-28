category = Category.find_by!(name: "Body Wash")

[
    {
        name: "Cinnamon Body Wash",
        summary: "1 Liter for Dry and Sensitive Skin",
        category_id: category.id,
        quantity: Random.rand(20),
        price: 27.00
    },
    {
        name: "Coconut Oil Body Wash",
        summary: "1 Liter for Dry and Sensitive Skin",
        category_id: category.id,
        quantity: Random.rand(20),
        price: 27.00
    },
    {
        name: "Green Tea Body Wash",
        summary: "1 Liter for Dry and Sensitive Skin",
        category_id: category.id,
        quantity: Random.rand(20),
        price: 27.00
    },
    {
        name: "Jasmine Body Wash",
        summary: "1 Liter for Dry and Sensitive Skin",
        category_id: category.id,
        quantity: Random.rand(20),
        price: 27.00
    },
    {
        name: "Mixed Berries Body Wash",
        summary: "1 Liter for Dry and Sensitive Skin",
        category_id: category.id,
        quantity: Random.rand(20),
        price: 27.00
    },
    {
        name: "Pine and Sage Body Wash",
        summary: "1 Liter for Dry and Sensitive Skin",
        category_id: category.id,
        quantity: Random.rand(20),
        price: 27.00
    },
    {
        name: "Tea Tree Body Wash",
        summary: "1 Liter for Dry and Sensitive Skin",
        category_id: category.id,
        quantity: Random.rand(20),
        price: 27.00
    },
    {
        name: "Vanilla and Cinnamon Body Wash",
        summary: "1 Liter for Dry and Sensitive Skin",
        category_id: category.id,
        quantity: Random.rand(20),
        price: 27.00
    },
].each do |product_properties|
    product = Product.new(product_properties)
    image_name = product_properties[:name].gsub(" ", "_").downcase + ".png"
    product.image.attach(
        io: File.open(Rails.root.join("app/assets/images/products/bottle.png")),
        filename: image_name
    )

    product.save
end
