class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.references :address, index: true, foreign_key: true
      t.integer :status, default: 0
      t.timestamps
    end
  end
end
