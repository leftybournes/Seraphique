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
        product_id = params[:product_id]
        user_id = current_user.id

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

        respond_to do |format|
            format.turbo_stream
        end
    end

    def update
    end

    def destroy
        destroyed = @item.destroy
        @count = current_user.shopping_cart_items.sum(:quantity)

        if destroyed
            respond_to do |format|
                format.html {
                    redirect_to shopping_cart_items_url,
                                notice: "Item was removed from your shopping cart"
                }

                format.json { head :no_content }
                format.turbo_stream
            end
        end
    end

    private

    def set_item
        @item = ShoppingCartItem.find(params[:id])
    end
end
