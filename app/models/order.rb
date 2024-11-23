class Order < ApplicationRecord
  enum :status, [ :placed, :paid, :shipped_out, :received, :rated ]

  has_many :order_items
  has_many :delivery_logs
  belongs_to :user
  belongs_to :address
end
