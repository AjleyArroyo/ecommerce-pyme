class AddReferenceToSpreeAddress < ActiveRecord::Migration[6.0]
  def change
    add_column :spree_addresses, :reference, :string
  end
end
