class ProductsController < ApplicationController
    before_action :set_product, only: %i[ edit update destroy ]
    before_action :ensure_authorized!, only: %i[ new edit create update destroy ]

    # GET /products or /products.json
    def index
        @products_by_categories =
            Category
                .where
                .not(name: ["Best Seller", "New Product"])
                .collect do |category|
            { category: category.name, products: category.products }
        end

        @selected_category =
            if params[:category].present?
                Category.find(params[:category].to_i)
            else
                nil
            end
    end

    # GET /products/1 or /products/1.json
    def show
        @page = params[:page] || 1
        @product = Product.includes(:usage_directions)
                       .find(params[:id])

        @total_reviews = @product.reviews.count
        @average_score = @product.reviews.average(:score)

        @review_scores =
            @product
                .reviews
                .select(:score)
                .order(score: :desc)
                .distinct
                .collect do |review_score|

            score_count =
                Review
                    .where(product_id: @product.id, score: review_score.score)
                    .count

            {
                score: review_score.score,
                fragment: score_count.to_d / @total_reviews.to_d * 100.to_d
            }
        end

        @reviews = Review.where(product_id: @product.id)
                       .order(created_at: :desc)
                       .limit(5)
 
        @pages = @total_reviews / @reviews.count
        @offset = 0
     end

    # GET /products/new
    def new
        @product = Product.new
        @category_options = Category.all.map do |category|
            [category.name, category.id]
        end

    end

    # GET /products/1/edit
    def edit
        @selected_categories = @product.categories.map do |category|
            category.id
        end

        @category_options = Category.all.map do |category|
            [category.name, category.id]
        end
    end

    # POST /products or /products.json
    def create
        @product = Product.new(product_params)
        @product.image.attach(product_params[:image])
        @product.categories = Category(where: category_params[:categories])

        respond_to do |format|
            if @product.save
                format.html { redirect_to product_url(@product), notice: "Product was successfully created." }
                format.json { render :show, status: :created, location: @product }
            else
                format.html { render :new, status: :unprocessable_entity }
                format.json { render json: @product.errors, status: :unprocessable_entity }
            end
        end
    end

    # PATCH/PUT /products/1 or /products/1.json
    def update
        @product.categories = Category.where(id: category_params[:categories])

        respond_to do |format|
            if @product.update(product_params)
                format.html { redirect_to product_url(@product), notice: "Product was successfully updated." }
                format.json { render :show, status: :ok, location: @product }
            else
                format.html { render :edit, status: :unprocessable_entity }
                format.json { render json: @product.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /products/1 or /products/1.json
    def destroy
        @product.destroy!

        respond_to do |format|
            format.html { redirect_to products_url, notice: "Product was successfully destroyed." }
            format.json { head :no_content }
        end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
        @product = Product.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_params
        params.require(:product)
            .permit(:name, :description, :quantity, :price, :image)
    end

    def category_params
        params.require(:product).permit(categories: [])
    end

    def ensure_authorized!
        if !administrator_signed_in?
            render file: "#{Rails.root}/public/404.html", status: 404
        end
    end
end
