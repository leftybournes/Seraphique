class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order, only: :show

  def index; end

  def show
    @title = "Your Order (#{@order.order_items.count} items)"
  end

  private

  def set_order
    @order = Order.find params[:id]
  end
end
