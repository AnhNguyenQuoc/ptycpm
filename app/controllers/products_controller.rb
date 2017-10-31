class ProductsController < ApplicationController
  load_and_authorize_resource
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => "You don't have permission"
  end

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash.now[:success] = "Create product complete"
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
    @product = Product.find_by(params[:id])
  end

  def update
    @product = Product.find_by(params[:id])
    if @product.update_attributes(product_params)
      flash[:success] = "Create product success"
      redirect_to products_path
    else
      flash[:danger] = "Error"
      render 'edit'
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to products_path
  end

  private

  def product_params
    params.require(:product).permit(:name, :price, :discount, :description, :view, :total, :catalog, :image)
  end
end
