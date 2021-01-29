class CreatePuppetConfigurations < ActiveRecord::Migration[6.1]
  def change
    create_table :puppet_configurations do |t|
      t.string :name
      t.string :slug
      t.integer :puppet_node_id
      t.integer :parent_id
      t.string :kind
      t.boolean :multiple_values, default: false, null: false

      t.timestamps
    end

    add_index :puppet_configurations, :slug
    add_index :puppet_configurations, :puppet_node_id
    add_index :puppet_configurations, :parent_id
  end
end
