class LineItemsController < ApplicationController
  
  before_action :set_line_item, only: [:show, :edit, :update, :destroy]

  # GET /line_items
  # GET /line_items.json
  def index
    @line_items = LineItem.all
  end

  # GET /line_items/1
  # GET /line_items/1.json
  def show
  end

  # GET /line_items/new
  def new
    @line_item = LineItem.new
  end

  # GET /line_items/1/edit
  def edit
  end

  # POST /line_items
  # POST /line_items.json
  def create
    chosen_product = Product.find(params[:product_id])
    current_cart = @current_cart

    if LineItem.exists?(:cart_id => @current_cart.id, :product_id => chosen_product)
      @line_item = @current_cart.line_items.find_by(product_id: chosen_product)
      @line_item.quantity += 1
    else  
      @line_item = LineItem.new
      @line_item.cart = @current_cart
      @line_item.product = chosen_product
    end

    @line_item.save
    redirect_to cart_path(@current_cart)
    
  end

  # PATCH/PUT /line_items/1
  # PATCH/PUT /line_items/1.json
  def update
    respond_to do |format|
      if @line_item.update(line_item_params)
        format.html { redirect_to @line_item, notice: 'Line item was successfully updated.' }
        format.json { render :show, status: :ok, location: @line_item }
      else
        format.html { render :edit }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /line_items/1
  # DELETE /line_items/1.json
  def destroy
    @line_item = LineItem.find(params[:id])
    @line_item.destroy
    redirect_to cart_path(@current_cart)
  end


  def add_quantity
    @line_item = LineItem.find(params[:id])
    @cart = @current_cart
    if @line_item.product.total > @line_item.quantity
        @line_item.quantity +=1
        @line_item.save
        #redirect_to cart_path(@current_cart)
    else
      flash[:danger] = "Max stock"
      #redirect_to cart_path(@current_cart)
    end
    respond_to do |format|
      format.js
    end
  end

  def reduce_quantity
    @line_item = LineItem.find(params[:id])
    @cart = @current_cart
    if @line_item.quantity > 1
      @line_item.quantity -=1 
    end
    @line_item.save
    #redirect_to cart_path(@current_cart)
    respond_to do |format|
      format.js
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_line_item
      @line_item = LineItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def line_item_params
      params.require(:line_item).permit(:product_id, :cart_id)
    end
end
