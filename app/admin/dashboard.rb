ActiveAdmin.register_page "Dashboard" do
  
  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    columns do
      column max_width: "400px", min_width: "200px" do
        panel "Out of stock" do
          table_for Product.out_of_stock.limit(5) do
            column("Name") {|product| link_to(product.name, admin_product_path(product))}
            column("Price") {|product| number_to_currency(product.price)}
            column("Total") {|product| status_tag("Out of stock")}
          end
          strong {link_to "View all products", admin_products_path}
        end
      end
      column max_width: "400px", min_width: "200px" do
        panel "New products" do
          table_for Product.order('id desc').limit(5) do
            column("Name")  {|product| link_to(product.name, admin_product_path(product))}
            column("Discount") {|product| product.discount}
            column("Price") {|product| number_to_currency(product.price)}
            column("Total") {|product| product.total}
            column("Source"){|product| product.source} 
          end
          strong {link_to "View all products", admin_products_path}
        end
      end
      column max_width: "600px", min_width: "200px" do
        panel "New user" do
          table_for User.order('id desc').limit(5) do
            column("Name")  {|user| link_to(user.name, admin_product_path(user))}
            column("Email") {|user| user.email}
            column("phone") {|user| user.phone}
            column("role"){|user| 
            if user.role
              status_tag("admin")
            else
              status_tag("customer")
            end}
          end
          strong {link_to "View all user", admin_users_path}
        end
      end
    end
    columns do
      column max_width: "400px", min_width: "200px" do
        panel "New orders" do
          table_for Order.limit(5) do
            column("Name") {|order| link_to(order.name, admin_order_path(order))}
            column("Email") {|order| order.email}
            column("Total") {|order| number_to_currency(order.total)}
            column("State") {|order|
              if order.state
               status_tag("complete")
              else
               status_tag("in processing")
              end
          }
          end
          strong {link_to "View all orders", admin_orders_path}
        end
      end
      column max_width: "400px", min_width: "200px" do
        panel "Sale per day" do
          column_chart Order.group_by_day_of_week(:created_at, format: "%a").count, refresh: 60
        end
      end
      column max_width: "500px", min_width: "200px" do
        panel "Order" do
          pie_chart [['Complete', Order.where(state: true).size], ['Inprocess', Order.where(state: false).size]]
        end
      end
    end
  end
end 