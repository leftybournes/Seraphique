def products_initialize
  body_wash = Category.find_by!(name: "Body Wash")
  product_variants = [
    { name: "500 ML" },
    { name: "1000 ML" }
  ]

  product_usage_directions = [
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

  products = [
    {
      product: {
        name: "Cinnamon Body Wash",
        summary: "1 Liter for Dry and Sensitive Skin",
        quantity: Random.rand(20),
        price: 27.00
      },
      category: body_wash
    },
    {
      product: {
        name: "Coconut Oil Body Wash",
        summary: "1 Liter for Dry and Sensitive Skin",
        quantity: Random.rand(20),
        price: 27.00
      },
      category: body_wash
    },
    {
      product: {
        name: "Green Tea Body Wash",
        summary: "1 Liter for Dry and Sensitive Skin",
        quantity: Random.rand(20),
        price: 27.00
      },
      category: body_wash
    },
    {
      product: {
        name: "Jasmine Body Wash",
        summary: "1 Liter for Dry and Sensitive Skin",
        quantity: Random.rand(20),
        price: 27.00
      },
      category: body_wash
    },
    {
      product: {
        name: "Mixed Berries Body Wash",
        summary: "1 Liter for Dry and Sensitive Skin",
        quantity: Random.rand(20),
        price: 27.00
      },
      category: body_wash
    },
    {
      product: {
        name: "Pine and Sage Body Wash",
        summary: "1 Liter for Dry and Sensitive Skin",
        quantity: Random.rand(20),
        price: 27.00
      },
      category: body_wash
    },
    {
      product: {
        name: "Tea Tree Body Wash",
        summary: "1 Liter for Dry and Sensitive Skin",
        quantity: Random.rand(20),
        price: 27.00
      },
      category: body_wash
    },
    {
      product: {
        name: "Vanilla and Cinnamon Body Wash",
        summary: "1 Liter for Dry and Sensitive Skin",
        quantity: Random.rand(20),
        price: 27.00
      },
      category: body_wash
    }
  ]

  categories = Category.where.not(name: ["Best Seller", "New Product"])
  product_names = products.collect { |product| product[:name] }

  categories.each do |category|
    rand(10..20).times do
      date = Faker::Date.between(from: 5.years.ago, to: Date.today)
      fruit = Faker::Food.fruits
      name = "#{fruit} #{category.name}"

      while product_names.include? name
        fruit = Faker::Food.fruits
        name = "#{fruit} #{category.name}"
      end

      product_names.append(name)

      price = Faker::Commerce.price(range: 20..40)

      products.append(
        {
          product: {
            name: name,
            summary: Faker::Lorem.sentence,
            quantity: Faker::Number.number(digits: 2),
            price: price,
            created_at: date,
            updated_at: date
          },
          category: category
        }
      )
    end
  end

  products.each do |product_properties|
    product = Product.create(product_properties[:product])

    product.categories << product_properties[:category]
    product.variants.create(product_variants)
    product.usage_directions.create(product_usage_directions)

    is_best_seller = [true, false].sample
    is_new_product = [true, false].sample

    if is_best_seller
      best_seller_category = Category.find_by(name: "Best Seller")
      product.categories << best_seller_category
    end

    if is_new_product
      new_category = Category.find_by(name: "New Product")
      product.categories << new_category
    end

    image_name = product_properties[:product][:name]
                   .gsub(" ", "_")
                   .downcase + ".png"

    product.image.attach(
      io: File.open(Rails.root.join("app/assets/images/products/bottle.png")),
      filename: image_name
    )

    stripe_product = Stripe::Product.create(
      {
        name: product.name,
        default_price_data: {
          currency: "USD",
          unit_amount: (product.price * 100).round.to_s
        },
        metadata: {
          categories: product_properties[:category].name,
          summary: product.summary,
          quantity: product.quantity,
          created_at: product.created_at,
          updated_at: product.updated_at,
        }
      }
    )

    product.stripe_product = StripeProduct.new(stripe_id: stripe_product.id)
    product.save
  end
end
