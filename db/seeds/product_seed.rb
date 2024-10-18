require_relative "products_synchronize"
require_relative "products_initialize"

api_products = Stripe::Product.list

if api_products.data.length > 0
  products_synchronize
else
  products_initialize
end

