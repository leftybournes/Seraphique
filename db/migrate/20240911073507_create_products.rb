class CreateProducts < ActiveRecord::Migration[7.1]
    def change
        create_table :products do |t|
            t.string :name
            t.text :description
            t.integer :quantity
            t.decimal :price

            t.belongs_to :category

            t.timestamps
        end
    end
end
