class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  check_authorization
  include SessionsHelper
  before_action :current_cart
  private
  def current_cart
    unless @current_cart
      if current_user
        cart = current_user.cart || Cart.create(:user => current_user)
        @current_cart = cart
      elsif session[:cart_id]
        @current_cart = Cart.where(:id => session[:cart_id]).first || Cart.create
      else
        @current_cart = Cart.create
      end
    end
    return @current_cart
  end
end
