class SessionsController < ApplicationController
  skip_authorization_check
  before_action :check_login, only: [:new, :create]
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in(user)
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      if user.role
        redirect_to admin_dashboard_path
      else
        flash[:success] = "Welcome to ChanRau"
        current_cart.user = current_user
        current_cart.save
        redirect_to root_path
      end
    else
      flash.now[:danger] = "Invalid email/password combination"
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    flash[:success] = "Logout success"
    redirect_to root_path
  end

  private
  def check_login
    unless !logged_in?
      redirect_to root_path
    end
  end

  
end
