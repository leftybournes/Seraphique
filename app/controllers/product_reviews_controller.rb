class ProductReviewsController < ApplicationController
    def index
        @limit = 5
        @page = params[:page].to_i

        previous_page =
            if @page > 1
                @page - 1
            else
                @page
            end

        @offset =
            if @page > 1
                previous_page * @limit
            else
                0
            end

        @reviews =
            Review
                .where(product_id: params[:product_id])
                .offset(@offset)
                .limit(@limit)

        @total = 
            Review.where(product_id: params[:product_id])
                .count

        @product_id = params[:product_id]
        @pages = @total / 5
    end
end
