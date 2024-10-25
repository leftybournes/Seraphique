class CreateOrderItems < ActiveRecord::Migration[7.1]
  def change
    create_table :order_items do |t|
      t.belongs_to :order, null: false, index: true, foreign_key: true
      t.references :product, null: false, index: true, foreign_key: true
      t.references :variant, null: false, index: true, foreign_key: true
      t.integer :quantity
      t.timestamps
    end
  end
end
