class AddObservationToSpreeLineItems < ActiveRecord::Migration[6.0]
  def change
    add_column :spree_line_items, :observation, :text
  end
end
