class AddSourceToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :source, :string
  end
end
