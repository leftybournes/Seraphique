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
        @page_count = @total / 5
        @pages =
            if @page < 3
                1..[5, @page_count].min
            elsif @page > @page_count - 3
                first_page = @page_count - 4
                first_page..[@page_count, 1].max
            else
                first_page = @page - 2
                last_page = @page + 2
                first_page..last_page
            end
    end
end
