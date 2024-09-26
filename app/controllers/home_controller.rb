class HomeController < ApplicationController
    layout "homepage"

    def index
        @products =
            if params[:category].present?
                Product.where(category_id: params[:category])
            else
                Product.all
            end

        @selected_category =
            if params[:category].present?
                Category.find(params[:category].to_i)
            else
                nil
            end
    end
end
