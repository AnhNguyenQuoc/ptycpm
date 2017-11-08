class OrdersController < ApplicationController
  skip_authorization_check
  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    @order.add_line_item_from_cart(@current_cart)
    if @order.save
        if logged_in?
          Cart.destroy(@current_cart.id)
        else
          Cart.destroy(session[:cart_id])
          session[:cart_id] = nil
         end
         redirect_to root_path
     else
      flash.now[:danger] = "Let try again!!"
      render 'new'
    end
  end

  private
  def order_params
    params.require(:order).permit(:name, :email, :address, :phone, :pay_type, :total)
  end
end
