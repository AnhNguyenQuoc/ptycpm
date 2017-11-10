class Cart < ApplicationRecord
  belongs_to :user, optional: true
  has_many :line_items, dependent: :destroy

  def total_price
    line_items.to_a.sum {|item| item.total_price}
  end

  def total_price_include_vat
    sum = line_items.to_a.sum {|item| item.total_price} + ((line_items.to_a.sum {|item| item.total_price} * 10) / 100)
    return sum + ((sum * 10)/ 100)
  end
end
