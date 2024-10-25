class Order < ApplicationRecord
  enum :status, [ :placed, :paid, :shipped_out, :recived, :rated ]

  has_many :order_items
  belongs_to :user
end
