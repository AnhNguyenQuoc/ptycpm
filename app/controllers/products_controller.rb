class ProductsController < ApplicationController
  load_and_authorize_resource :except => [:index, :show]
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path
  end
  
  def index
    @product = Product.order('view desc').limit(5)
    @products = Product.where(nil).paginate(:page => params[:page], :per_page => 9)
    @products = @products.catalog(params[:catalog]).paginate(:page => params[:page], :per_page => 9) if params[:catalog].present?
    @products = @products.starts_with(params[:starts_with]).paginate(:page => params[:page], :per_page => 9) if params[:starts_with].present?
  end

  def show  
    @product = Product.find(params[:id])
    @product.count_view
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash.now[:success] = "Create product complete"
      redirect_to products_path
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
    if Product.find(params[:id]).destroy
    flash[:success] = "Product deleted"
    redirect_to root_path
    else
    flash[:danger] = "We still have orders of this product"
    redirect_to root_path
    end
    
  end

  private

  def product_params
    params.require(:product).permit(:name, :price, :discount, :description, :view, :total, :catalog, :image ,:source)
  end
end
