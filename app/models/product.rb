class Product < ApplicationRecord
    has_one_attached :image do |attachable|
        attachable.variant :thumb, resize_to_limit: [300, 300], preprocessed: true
        attachable.variant :small, resize_to_limit: [100, 100], preprocessed: true
    end

    has_rich_text :description
    has_many :reviews
    has_many :categories, through: :product_categories
end
