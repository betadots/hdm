class AddNameToPuppetNodes < ActiveRecord::Migration[6.1]
  def change
    add_column :puppet_nodes, :name, :string
  end
end
