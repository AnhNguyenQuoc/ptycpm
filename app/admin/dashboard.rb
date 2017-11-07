ActiveAdmin.register_page "Dashboard" do
  
  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    columns do
      column max_width: "400px", min_width: "200px" do
        panel "Out of stock" do
          table_for Product.out_of_stock.limit(10) do
            column("Name") {|product| link_to(product.name, admin_product_path(product))}
            column("Price") {|product| number_to_currency(product.price)}
            column("Total") {|product| status_tag("Out of stock")}
          end
        end
      end
      column max_width: "400px", min_width: "200px" do
        panel "New products" do
          table_for Product.order('id desc').limit(10) do
            column("Name")  {|product| link_to(product.name, admin_product_path(product))}
            column("Price") {|product| number_to_currency(product.price)}
            column("Total") {|product| product.total}
            column("Image") {|product| image_tag(product.image.url(:thumb))}
            column("Source"){|product| product.source} 
          end
          strong {link_to "View all products", admin_products_path}
        end
      end
    end
  end
end 