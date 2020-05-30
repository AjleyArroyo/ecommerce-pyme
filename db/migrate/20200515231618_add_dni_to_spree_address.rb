class AddDniToSpreeAddress < ActiveRecord::Migration[6.0]
  def change
    add_column :spree_addresses, :dni, :string
    add_column :spree_addresses, :nit, :string
    add_column :spree_addresses, :social_reason, :string
  end
end
