class ShoppingCartItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [ :destroy ]

  def index
    user_has_default_address = current_user.addresses.where(default: true).size > 0

    @address = current_user.addresses.where(default: true).first if user_has_default_address
    @address = current_user.addresses.first unless user_has_default_address

    earliest_shipping = 5.days.from_now
    latest_shipping = 7.days.from_now

    earliest_year = earliest_shipping.strftime("%Y")
    latest_year = latest_shipping.strftime("%Y")

    earliest_month = earliest_shipping.strftime("%m")
    latest_month = latest_shipping.strftime("%m")

    earliest_text =
      if earliest_year != latest_year
        earliest_shipping.strftime("%d %B, %Y")
      elsif earliest_month == latest_month
        earliest_shipping.strftime("%d")
      else
        earliest_shipping.strftime("%d %B")
      end

    latest_text = latest_shipping.strftime("%d %B, %Y")

    @shipping_range = "#{earliest_text} - #{latest_text}"
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
