class CreatePuppetNodes < ActiveRecord::Migration[6.0]
  def change
    create_table :puppet_nodes do |t|
      t.string :fqdn
      t.string :role
      t.belongs_to :puppet_environment, null: false, foreign_key: true
      t.string :zone
      t.string :os_family
      t.string :os_lsbdistcodename
      t.string :organization
      t.string :config_file_name

      t.timestamps
    end
  end
end
