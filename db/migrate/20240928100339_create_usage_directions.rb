class CreateUsageDirections < ActiveRecord::Migration[7.1]
    def change
        create_table :usage_directions do |t|
            t.belongs_to :product, null: false, foreign_key: true
            t.integer :order
            t.string :content

            t.timestamps
        end
    end
end
