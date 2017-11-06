class LineItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart

  def total_price
<<<<<<< HEAD
    (product.price.to_f * quantity) + (product.discount * product.price.to_f)
=======
    (product.price.to_f * quantity) - ((product.discount * product.price) / 100)
>>>>>>> add-cart
  end
end
