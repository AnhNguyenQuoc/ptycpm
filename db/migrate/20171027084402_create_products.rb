class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name
      t.decimal :price, default: 0.0
      t.integer :discount, default: 0
      t.text :description
      t.integer :view,default: 0
      t.integer :total, default: 0
      t.integer :catalog, default: 0, allow_null: false
      t.timestamps
    end
  end
end
