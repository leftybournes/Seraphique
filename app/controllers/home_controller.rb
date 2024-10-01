class HomeController < ApplicationController
    layout "homepage"

    def index
        @best_sellers =
            Product.includes(:categories)
                .where(categories: { name: "Best Seller" })
                .limit(5)

        @new_products =
            Product.includes(:categories)
                .where(categories: { name: "New Product" })
                .limit(5)
    end
end
