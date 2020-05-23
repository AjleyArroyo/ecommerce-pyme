class AddDniToSpreeAddress < ActiveRecord::Migration[6.0]
  def change
    add_column :spree_addresses, :dni, :string
  end
end
