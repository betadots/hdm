class AddSlugToPuppetNode < ActiveRecord::Migration[6.1]
  def change
    add_column :puppet_nodes, :slug, :string
    add_index :puppet_nodes, :slug, unique: true
  end
end
