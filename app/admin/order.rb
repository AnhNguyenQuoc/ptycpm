ActiveAdmin.register Order do

    permit_params :name, :email, :phone, :address, :pay_type, :total, :state, :user_id

    config.per_page = 20

    filter :name
    filter :email
    filter :address
    filter :pay_type, as: :select

    scope :all, default: true
    scope :complete
    scope :inprocessing


    batch_action :Complete do |ids|
        batch_action_collection.find(ids).each do |order|
          order.state = true
          order.save
        end
        redirect_to admin_orders_path, alert: "Order change to complete"
    end


    index do
        selectable_column
        column :name
        column :email
        column :phone
        column :address
        column :pay_type
        column :total do |order|
            number_to_currency(order.total)
        end
        column :state do |order|
            if order.state
                status_tag("complete")
            else
                status_tag("in processing")
            end
        end
        actions
    end
    form do |f|
        f.inputs "Orders" do
            f.input :name
            f.input :email
            f.input :phone
            f.input :address
            f.input :pay_type, as: :select, collection: Order.pay_types.keys, include_blank: "Select your pay type"
            f.input :state, as: :select, collection: {"Complete" => true, "In Processing" => false}, include_blank: 'Select your order state'
            f.input :total
        end
        f.actions
    end
end
