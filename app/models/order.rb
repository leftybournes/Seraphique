class Order < ApplicationRecord
  enum :status, [ :placed, :paid, :shipped_out, :received, :rated ]

  has_many :order_items
  has_many :delivery_logs
  belongs_to :user
  belongs_to :address

  def reference_id
    created = self.created_at.strftime("%y%m%d")
    padded_id = self.id.to_s.rjust(6, "0")

    "#{created}#{padded_id}"
  end

  def total_price
    total = self.order_items.inject(0) do |sum, order_item|
      sum + (order_item.product.price * order_item.quantity)
    end

    total
  end
end
