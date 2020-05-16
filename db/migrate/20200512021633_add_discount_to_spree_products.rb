class AddDiscountToSpreeProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :spree_products, :discount, :decimal, precision: 8, scale: 2
  end
end
