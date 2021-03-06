ActiveAdmin.register User do

    permit_params :name, :email, :password, :password_confirmation, :phone, :address, :role
    filter :name
    filter :email
    filter :role, as: :select, collection: {
        "admin" => true,
        "customer" => false
    }
    scope :all, default: true
    scope :admin
    scope :customer
    config.per_page = 20

    batch_action :to_admin do |ids|
        batch_action_collection.find(ids).each do |user|
          user.role = true
          user.save
        end
        redirect_to admin_users_path, alert: "User change admin complete"
    end
    batch_action :destroy do |ids|
        batch_action_collection.find(ids).each do |user|
          user.delete
          redirect_to admin_users_path, alert: "Delete user complete"
        end
        
    end


    index do
        selectable_column
        column :name
        column :email
        column :phone
        column :address
        column :role do |user|
            if user.role
                status_tag("Admin")
            else
                status_tag("Customer")
            end
        end
        actions
    end
    
    form do |f|
        f.inputs "Users" do
            f.input :name
            f.input :email
            f.input :password
            f.input :password_confirmation
            f.input :phone
            f.input :address
            f.input :role, as: :select, collection: {"Admin" => true, "Customer" => false}, include_blank: 'Select your role'
        end
        f.actions
    end

    controller do
        def update
          if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
            params[:user].delete("password")
            params[:user].delete("password_confirmation")
          end
          super
        end
    end
end
