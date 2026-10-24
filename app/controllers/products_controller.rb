
class ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update destroy]

  # GET /products or /products.json
  def index
    @products = Product.all
  end

  # GET /products/1 or /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products or /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: "Product was successfully created." }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @product.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        @product.broadcast_replace_later_to(
          "store/products",
          partial: "store/product"
        )

        format.html do
          redirect_to @product,
                      notice: "Product was successfully updated.",
                      status: :see_other
        end
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @product.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    respond_to do |format|
      if @product.destroy
        format.html do
          redirect_to products_path,
                      notice: "Product was successfully destroyed.",
                      status: :see_other
        end
        format.json { head :no_content }
      else
        format.html do
          redirect_to products_path,
                      alert: "Product cannot be deleted because it is associated with line items.",
                      status: :see_other
        end
        format.json { render json: @product.errors, status: :unprocessable_content }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def product_params
    params.expect(product: [:title, :description, :image, :price])
  end
end