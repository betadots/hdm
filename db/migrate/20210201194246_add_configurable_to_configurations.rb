class AddConfigurableToConfigurations < ActiveRecord::Migration[6.1]
  def change
    remove_index :puppet_configurations, :slug
    remove_column :puppet_configurations, :slug, :string

    remove_index :puppet_configurations, :puppet_node_id
    remove_column :puppet_configurations, :puppet_node_id, :integer

    add_column :puppet_configurations, :configurable_type, :string
    add_column :puppet_configurations, :configurable_id, :integer

    add_index :puppet_configurations, [:configurable_id, :configurable_type], name: 'index_puppet_configurations_on_configurable'
  end
end
