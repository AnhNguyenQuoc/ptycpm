class LayoutsController < ApplicationController

  skip_authorization_check
  def index
    @products = Product.where('total > 0').order("view desc").limit(5)
  end

  def show
    
  end
end
