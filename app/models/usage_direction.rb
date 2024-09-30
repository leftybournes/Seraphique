class UsageDirection < ApplicationRecord
    belongs_to :product

    default_scope { order(:order) }
end
