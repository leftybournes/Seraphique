class PaymentsController < ApplicationController
  before_action :authenticate_user!

  def create
    return redirect_to request.referrer unless payments_params[:products][:ids]

    items = ShoppingCartItem.find payments_params[:products][:ids]

    items.each do |item|
      item.variant_id = payments_params[:products][item.id.to_s][:variant]
      item.quantity = payments_params[:products][item.id.to_s][:quantity]
      item.save!
    end

    line_items = items.collect do |item|
      stripe_product = Stripe::Product
                         .retrieve(item.product.stripe_product.stripe_id)

      {
        price: item.product.stripe_product.stripe_price_id,
        quantity: payments_params[:products][item.id.to_s][:quantity]
      }
    end

    session = Stripe::Checkout::Session.create(
      success_url: URI.decode_uri_component(
        success_payments_url(session_id: "{CHECKOUT_SESSION_ID}")
      ),
      cancel_url: shopping_cart_items_url,
      line_items: line_items,
      mode: "payment"
    )

    redirect_to session.url, status: 303, allow_other_host: true
  end

  def success
    return redirect_to root_path unless params[:session_id]

    line_items = Stripe::Checkout::Session.list_line_items params[:session_id]
    stripe_item_ids = line_items.collect { |item| item.price.product }
    cart_items = current_user.shopping_cart_items.select do |item|
      stripe_item_ids.include? item.product.stripe_product.stripe_id
    end

    @order = current_user.orders.create

    cart_items.each do |item|
      @order.order_items.create(
        product_id: item.product_id,
        variant_id: item.variant_id,
        quantity: item.quantity
      )
    end

    ShoppingCartItem.destroy_by(id: cart_items.collect { |item| item.id })
  end

  private

  def payments_params
    params.require(:payments).permit(products: {})
  end
end
