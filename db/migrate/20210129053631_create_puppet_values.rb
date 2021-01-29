class CreatePuppetValues < ActiveRecord::Migration[6.1]
  def change
    create_table :puppet_values do |t|
      t.string :value
      t.string :slug
      t.references :puppet_configuration, null: false, foreign_key: true

      t.timestamps
    end
    add_index :puppet_values, :slug
  end
end
