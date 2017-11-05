class Cart < ApplicationRecord
  belongs_to :user
  has_many :line_items, dependent: :destroy

  def sub_total
    sum = 0
    self.line_items.each do |item|
      sum += item.total_price
    end
    return sum
  end
end
