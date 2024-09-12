class Product < ApplicationRecord
    has_one_attached :image do |attachable|
        attachable.variant :thumb, resize_to_limit: [260, 260], preprocessed: true
    end

    belongs_to :category
end
