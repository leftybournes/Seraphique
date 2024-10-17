class CreateStripeProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :stripe_products do |t|
      t.belongs_to :product, null: false, foreign_key: true
      t.string :stripe_id

      t.timestamps
    end
  end
end
