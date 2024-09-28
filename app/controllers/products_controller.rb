class ProductsController < ApplicationController
    before_action :set_product, only: %i[ show edit update destroy ]
    before_action :ensure_authorized!, only: %i[ new edit create update destroy ]

    # GET /products or /products.json
    def index
        @products =
            if params[:category].present?
                Product.joins(:categories).where(categories: { id: params[:category] })
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

    # GET /products/1 or /products/1.json
    def show
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
    end

    # POST /products or /products.json
    def create
        @product = Product.new(product_params)
        @product.image.attach(product_params[:image])

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
            .permit(:name, :description, :quantity, :price, :image, :category_id)
    end

    def ensure_authorized!
        if !administrator_signed_in?
            render file: "#{Rails.root}/public/404.html", status: 404
        end
    end
end
