class PaymentsController < ApplicationController
  before_action :authenticate_user!

  def create
    return redirect_to request.referrer unless payments_params[:products][:ids]

    items = ShoppingCartItem.find payments_params[:products][:ids]
    order = current_user
              .orders
              .create(address: Address.find(payments_params[:address]))

    items.each do |item|
      order.order_items.create(
        product_id: item.product_id,
        variant_id: payments_params[:products][item.id.to_s][:variant],
        quantity: payments_params[:products][item.id.to_s][:quantity]
      )
    end

    order.save

    line_items = items.collect do |item|
      {
        price: item.product.stripe_product.stripe_price_id,
        quantity: payments_params[:products][item.id.to_s][:quantity]
      }
    end

    ShoppingCartItem.destroy_by(id: items.collect { |item| item.id })
    shipping_fee = 1000

    session = Stripe::Checkout::Session.create(
      success_url: URI.decode_uri_component(
        success_payments_url(
          session_id: "{CHECKOUT_SESSION_ID}",
          order: order.id
        )
      ),
      shipping_options: [
        {
          shipping_rate_data: {
            type: :fixed_amount,
            fixed_amount: {
              amount: shipping_fee,
              currency: :usd
            },
            display_name: 'Standard shipping',
            delivery_estimate: {
              minimum: {
                unit: 'business_day',
                value: 5,
              },
              maximum: {
                unit: 'business_day',
                value: 7,
              },
            },
          }
        }
      ],
      cancel_url: shopping_cart_items_url,
      line_items: line_items,
      mode: "payment"
    )

    redirect_to session.url, status: 303, allow_other_host: true
  end

  def success
    return redirect_to root_path unless params[:session_id]

    @order = Order.find params[:order]
    @order.paid!
  end

  private

  def payments_params
    params.require(:payments).permit(:address, products: {})
  end
end
