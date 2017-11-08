class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.string :name
      t.string :email
      t.string :address
      t.string :phone
      t.integer :pay_type
      t.boolean :state, default: false
      t.integer :VAT,default: 10

      t.timestamps
    end
  end
end
