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

  Stripe::Product.list.data.each do |stripe_product|
  end
end
