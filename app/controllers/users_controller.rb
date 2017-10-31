class UsersController < ApplicationController

  before_action :check_user, only: [:edit, :update]
  skip_authorization_check
  
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to ChanRau"
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit  
    @user = User.find_by(params[:id])
  end

  def update
    @user = User.find_by(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Update complete"
      redirect_to root_path
    else
      render 'edit'
    end
  end

  private

  def check_user
    unless logged_in?
      flash[:danger] = "Please log in"
      redirect_to login_path
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :phone, :address, :role)
  end
end
