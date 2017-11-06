class LineItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart

  def total_price
    (product.price.to_f * quantity) - ((product.discount * product.price) / 100)
  end
end
