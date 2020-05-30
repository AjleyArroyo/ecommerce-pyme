class AddDescriptionToSpreeLineItems < ActiveRecord::Migration[6.0]
  def change
    add_column :spree_line_items, :description, :text, default: ''
  end
end
