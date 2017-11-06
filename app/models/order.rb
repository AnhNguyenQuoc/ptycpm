class Order < ApplicationRecord
    has_many :line_items, dependent: :destroy
    enum pay_type: {
        "Credit Cart" => 1,
        "Purchase order" => 2,
        "Visa" => 3
    }

    def add_line_item_from_cart(cart)
        cart.line_items.each do |item|
            item.cart_id = nil
            line_items << item
        end
    end
end
