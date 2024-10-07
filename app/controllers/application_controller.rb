class ApplicationController < ActionController::Base
    before_action :initialize_header_data

    attr_reader :categories
    attr_reader :shopping_cart_item_count

    def initialize_header_data
        @categories = Category.all
        @shopping_cart_item_count = 0

        if user_signed_in?
            @shopping_cart_item_count = current_user.shopping_cart_items.sum(:quantity)
        end
    end
end
