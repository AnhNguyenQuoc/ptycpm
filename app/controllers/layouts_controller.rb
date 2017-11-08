class LayoutsController < ApplicationController
  skip_authorization_check

  def index
    @products = Product.order("view desc").limit(5)
  end
end
