class Administrator::OrdersController < ApplicationController
  before_action :authenticate_administrator!

  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
  end
end
