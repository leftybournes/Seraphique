class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :shopping_cart_items
  has_many :reviews
  has_many :addresses
  has_many :payment_cards
  has_many :orders

  def full_name
    "#{self.first_name} #{self.last_name}"
  end
end
