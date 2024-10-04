class CreateAddresses < ActiveRecord::Migration[7.1]
    def change
        create_table :addresses do |t|
            t.references :user, null: false, foreign_key: true
            t.string :line_1, null: false
            t.string :line_2
            t.string :city, null: false
            t.string :state, null: false
            t.string :country, null: false
            t.string :postal_code

            t.timestamps
        end
    end
end
