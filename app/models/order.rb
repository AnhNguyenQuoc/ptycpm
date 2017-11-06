class Order < ApplicationRecord
    has_many :line_items, dependent: :destroy
    belongs_to :user, optional: true
    enum pay_type: {
        "Credit Cart" => 1,
        "Purchase order" => 2,
        "Visa" => 3
    }

    def add_line_item_from_cart(cart)
        cart.line_items.each do |item|
            product = Product.find_by(id: item.product)
            product.update_attribute(:total, product.total - item.quantity)
            item.cart_id = nil
            line_items << item
        end
    end

    def total_price
        sum = line_items.to_a.sum {|item| item.total_price} + ((line_items.to_a.sum {|item| item.total_price} * self.VAT) / 100)
        self.update_attribute(:total, sum)
        return sum
    end
end
