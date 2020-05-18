class AddNoDiscountMode < ActiveRecord::Migration[6.0]
  def change
    add_column :spree_products, :no_discount_mode, :boolean, default: false
    add_column :spree_variants, :no_discount_mode, :boolean, default: false
  end
end
