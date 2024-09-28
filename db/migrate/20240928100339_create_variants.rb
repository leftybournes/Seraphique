class CreateVariants < ActiveRecord::Migration[7.1]
    def change
        create_table :variants do |t|
            t.belongs_to :product, null: false, foreign_key: true
            t.string :name

            t.timestamps
        end
    end
end
