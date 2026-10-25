class LineItemsController < ApplicationController
  allow_unauthenticated_access only: %i[ create ]

  include CurrentCart

  before_action :set_cart, only: %i[create]
  before_action :set_line_item, only: %i[show edit update destroy]

  def index
    @line_items = LineItem.all
  end

  def show
  end

  def new
    @line_item = LineItem.new
  end

  def edit
  end

  def create
    product = Product.find(params[:product_id])
    @line_item = @cart.add_product(product)

    respond_to do |format|
      if @line_item.save
        format.turbo_stream do
          @current_item = @line_item

          render turbo_stream: turbo_stream.replace(
            :cart,
            partial: "layouts/cart",
            locals: { cart: @cart }
          )
        end

        format.html { redirect_to store_index_url }
        format.json { render :show, status: :created, location: @line_item }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @line_item.update(line_item_params)
        format.html do
          redirect_to @line_item,
                      notice: "Line item was successfully updated."
        end
        format.json { render :show, status: :ok, location: @line_item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json do
          render json: @line_item.errors,
                 status: :unprocessable_entity
        end
      end
    end
  end

  def destroy
    @line_item.destroy!

    respond_to do |format|
      format.html do
        redirect_to line_items_path,
                    status: :see_other,
                    notice: "Line item was successfully destroyed."
      end
      format.json { head :no_content }
    end
  end

  private

  def set_line_item
    @line_item = LineItem.find(params.expect(:id))
  end

  def line_item_params
    params.expect(line_item: [ :product_id ])
  end
end
