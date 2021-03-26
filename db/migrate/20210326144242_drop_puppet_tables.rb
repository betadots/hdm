class DropPuppetTables < ActiveRecord::Migration[6.1]
  def change
    drop_table :puppet_configurations
    drop_table :puppet_environments
    drop_table :puppet_nodes
    drop_table :puppet_options
    drop_table :puppet_values
  end
end
