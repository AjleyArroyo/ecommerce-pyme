class AddEnabledToSpreeStates < ActiveRecord::Migration[6.0]
  def change
    add_column :spree_states, :enabled, :boolean, default: true
  end
end
