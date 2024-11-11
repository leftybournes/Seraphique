class Order < ApplicationRecord
  enum :status, [ :placed, :paid, :shipped_out, :received, :rated ]

  has_many :order_items
  belongs_to :user
  belongs_to :address
end
