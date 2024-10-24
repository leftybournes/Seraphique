def products_synchronize
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

  Stripe::Product.list(limit: 100).data.each do |stripe_product|
    price = Stripe::Price.retrieve(stripe_product.default_price)

    params = {
      name: stripe_product.name,
      summary: stripe_product.metadata.summary,
      quantity: stripe_product.metadata.quantity.to_i,
      price: price.unit_amount / 100,
      created_at: stripe_product.metadata.created_at,
      updated_at: stripe_product.metadata.created_at
    }


    product = Product.create(params)

    category = Category.find_by(name: stripe_product.metadata.categories)
    product.categories << category
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

    image_name = product.name
                   .gsub(" ", "_")
                   .downcase + ".png"

    product.image.attach(
      io: File.open(Rails.root.join("app/assets/images/products/bottle.png")),
      filename: image_name
    )

    product.stripe_product = StripeProduct.new(
      stripe_id: stripe_product.id,
      stripe_price_id: stripe_product.default_price
    )
  end
end
