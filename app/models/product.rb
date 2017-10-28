class Product < ApplicationRecord
    enum catalog: {
        "Leafy and salad vegetables" => 1,
        "Fruits" => 2,
        "Flowers and flower buds" => 3,
        "Podded vegetables" => 4,
        "Bulb and stem vegetables" => 5,
        "Root and tuberous vegetables" => 6,
        "Sea vagetables0" => 7
    }
    
has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
validates :name, presence: true, length: {minimum: 4}
validates :price, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0}
validates :discount, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0}
validates :discription, presence: true, length: {maximum: 50}
validates :total, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0}
validates :catalog, presence: true
validates :image, attachment_presence: true
end
