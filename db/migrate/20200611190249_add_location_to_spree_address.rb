class AddLocationToSpreeAddress < ActiveRecord::Migration[6.0]
  def change
    add_column :spree_addresses, :latitude, :decimal, {:precision=>10, :scale=>6}
    add_column :spree_addresses, :longitude, :decimal, {:precision=>10, :scale=>6}
  end
end
