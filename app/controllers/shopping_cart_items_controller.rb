class ShoppingCartItemsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_item, only: [ :destroy ]

    def index
    end

    def show
    end

    def new
    end

    def edit
    end

    def create
    end

    def new_shopping_cart_item_for_user
        product_id = params[:product_id]
        user_id = params[:user_id]

        product = ShoppingCartItem.create_with(quantity: 1)
                      .find_or_create_by(
                          product_id: product_id,
                          user_id: user_id
                      )

        if not product.previously_new_record?
            product.quantity += 1
        end

        product.save

        @count = current_user.shopping_cart_items.sum(:quantity)
    end

    def update
    end

    def destroy
        @item.destroy!

        respond_to do |format|
            format.html {
                redirect_to shopping_cart_items_url,
                            notice: "Item was removed from your shopping cart"
            }

            format.json { head :no_content }
        end
    end

    private

    def set_item
        @item = ShoppingCartItem.find(params[:id])
    end
end
