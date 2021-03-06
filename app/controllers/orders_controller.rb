class OrdersController < ApplicationController

  def index
    @orders = Order.find_by(user_id: current_user.id)
  end

  def show
    @order = Order.find(params[:id])
  end

  def new
    @order = Order.new
    @cart = @current_cart
  end

  def create
    
    @order = Order.new(order_params)
    @order.add_line_item_from_cart(@current_cart)
    @cart = @current_cart
      if @order.save
          if logged_in?
            Cart.destroy(@current_cart.id)
            @order.update_attribute(:total, @order.total_price)
          else
            Cart.destroy(session[:cart_id])
            session[:cart_id] = nil
            @order.update_attribute(:total, @order.total_price)
          end
          flash[:success] = "Your order is done"
          redirect_to root_path
        else
          flash[:danger] = "Let's try again"
          render 'new'
      end
  end

  private
  def order_params
    params.require(:order).permit(:name, :email, :address, :phone, :pay_type)
  end
end
