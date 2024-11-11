module OrdersHelper
  def order_is_or_past_status(order, status)
    Order.statuses[order.status] >= Order.statuses[status]
  end
end
