class CreatePaymentCards < ActiveRecord::Migration[7.1]
  def change
    create_table :payment_cards do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name, null: false
      t.string :number, null: false
      t.string :expiration, null: false
      t.string :cvv, null: false
      t.string :nickname

      t.timestamps
    end
  end
end
