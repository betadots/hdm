class AddSlugToPuppetEnvironment < ActiveRecord::Migration[6.1]
  def change
    add_column :puppet_environments, :slug, :string
    add_index :puppet_environments, :slug, unique: true
  end
end
