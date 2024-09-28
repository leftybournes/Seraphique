main_category = Category.find_by!(name: "Body Wash")

[
    {
        name: "Cinnamon Body Wash",
        summary: "1 Liter for Dry and Sensitive Skin",
        quantity: Random.rand(20),
        price: 27.00
    },
    {
        name: "Coconut Oil Body Wash",
        summary: "1 Liter for Dry and Sensitive Skin",
        quantity: Random.rand(20),
        price: 27.00
    },
    {
        name: "Green Tea Body Wash",
        summary: "1 Liter for Dry and Sensitive Skin",
        quantity: Random.rand(20),
        price: 27.00
    },
    {
        name: "Jasmine Body Wash",
        summary: "1 Liter for Dry and Sensitive Skin",
        quantity: Random.rand(20),
        price: 27.00
    },
    {
        name: "Mixed Berries Body Wash",
        summary: "1 Liter for Dry and Sensitive Skin",
        quantity: Random.rand(20),
        price: 27.00
    },
    {
        name: "Pine and Sage Body Wash",
        summary: "1 Liter for Dry and Sensitive Skin",
        quantity: Random.rand(20),
        price: 27.00
    },
    {
        name: "Tea Tree Body Wash",
        summary: "1 Liter for Dry and Sensitive Skin",
        quantity: Random.rand(20),
        price: 27.00
    },
    {
        name: "Vanilla and Cinnamon Body Wash",
        summary: "1 Liter for Dry and Sensitive Skin",
        quantity: Random.rand(20),
        price: 27.00
    },
].each do |product_properties|
    product = Product.create(product_properties)
    product.product_categories.create(product_id: product.id, category_id: main_category.id)
    product.variants.create(
        [
            { name: "500 ML" },
            { name: "1000 ML" }
        ]
    )

    product.usage_directions.create(
        [
            {
                content: "Dampen Skin: Wet your skin thoroughly with warm water.",
                order: 1
            },
            {
                content: "Apply: Dispense a small amount of Seraphique Pine and Sage Body Wash onto your loofah or palm.",
                order: 2
            },
            {
                content: "Massage: Gently massage the lather into your skin, focusing on areas that need extra attention.",
                order: 3
            },
            {
                content: "Rinse: Rinse your body thoroughly with warm water to remove all traces of the body wash.",
                order: 4
            },
            {
                content: "Pat Dry: Gently pat your skin dry with a soft towel.",
                order: 5
            }
        ]
    )

    is_best_seller = [true, false].sample
    is_new_product = [true, false].sample

    if is_best_seller
        category = Category.find_by(name: "Best Seller")
        product.product_categories.create(product_id: product.id, category_id: category.id)
    end

    if is_new_product
        category = Category.find_by(name: "New Product")
        product.product_categories.create(product_id: product.id, category_id: category.id)
    end

    image_name = product_properties[:name].gsub(" ", "_").downcase + ".png"
    product.image.attach(
        io: File.open(Rails.root.join("app/assets/images/products/bottle.png")),
        filename: image_name
    )
end
