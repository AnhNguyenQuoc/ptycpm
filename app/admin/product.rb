ActiveAdmin.register Product do
    permit_params :name, :price, :discount, :description, :view, :total, :catalog, :source, :image
    filter :name
    filter :price
    filter :catalog, as: :select, collection: {"Leafy and salad vegetables" => 1,
    "Fruits" => 2,
    "Flowers and flower buds" => 3,
    "Podded vegetables" => 4,
    "Bulb and stem vegetables" => 5,
    "Root and tuberous vegetables" => 6,
    "Sea vagetables" => 7}

    filter :source, as: :select
    scope :all, default: true
    scope :out_of_stock
    config.per_page = 20
    
    index do
        selectable_column
        column :name
        column :price do |product|
            number_to_currency product.price
        end
        column :discount
        column :description
        column :view
        column :total
        column :catalog
        column :source
        column :image do |m|
            image_tag m.image.url(:thumb)
        end
        actions
    end


    form do |f|
        f.inputs "Products" do
            f.input :name
            f.input :price, type: :numeric
            f.input :discount
            f.input :description
            f.input :view, as: :hidden
            f.input :total
            f.input :image, required: true, as: :file
            f.input :catalog, as: :select, collection: Product.catalogs.keys, include_blank: "Select catalogs for your product"
            f.input :source, as: :country, include_blank: "Select source of you product", priority_countries: ["JP", "TH", "CN","VN", "US"], only: []
        end
        f.actions
    end
end
