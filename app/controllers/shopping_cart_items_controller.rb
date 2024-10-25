class ShoppingCartItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [ :destroy ]

  def index
  end

  def create
    product_id = params[:product_id]
    user_id = current_user.id

    item = ShoppingCartItem
             .create_with(quantity: 1)
             .find_or_create_by(
               product_id: product_id,
               user_id: user_id
             )

    if not item.previously_new_record?
      item.quantity += 1
    end

    item.save

    @count = current_user.shopping_cart_items.sum(:quantity)

    respond_to do |format|
      format.turbo_stream
    end
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
