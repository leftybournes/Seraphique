class CreateDeliveryLogs < ActiveRecord::Migration[7.1]
  def change
    create_table :delivery_logs do |t|
      t.belongs_to :order, null: false, index: true, foreign_key: true
      t.string :description, null: false
      t.timestamps
    end
  end
end
