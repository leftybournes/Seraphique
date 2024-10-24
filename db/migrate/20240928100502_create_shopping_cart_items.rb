class CreateShoppingCartItems < ActiveRecord::Migration[7.1]
  def change
    create_table :shopping_cart_items do |t|
      t.references :product, null: false, index: true, foreign_key: true
      t.belongs_to :user, null: false, index: true, foreign_key: true
      t.references :variant, index: true, foreign_key: true
      t.integer :quantity
      t.timestamps
    end
  end
end
