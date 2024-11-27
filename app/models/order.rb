class Order < ApplicationRecord
  before_save :set_defaults

  enum :status, [ :placed, :paid, :shipped_out, :received, :rated ]

  has_many :order_items
  has_many :delivery_logs
  belongs_to :user
  belongs_to :address

  def set_defaults
    self.reference_id = ULID.generate
  end
end
