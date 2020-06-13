class AddSkipValidationToSpreeAddress < ActiveRecord::Migration[6.0]
  def change
    add_column :spree_addresses, :skip_validation, :boolean, default: false
  end
end
