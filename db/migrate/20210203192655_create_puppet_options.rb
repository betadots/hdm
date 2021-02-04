class CreatePuppetOptions < ActiveRecord::Migration[6.1]
  def change
    create_table :puppet_options do |t|
      t.string :name
      t.string :slug
      t.references :puppet_node, null: false, foreign_key: true

      t.timestamps
    end

    add_index :puppet_options, :slug
  end
end
