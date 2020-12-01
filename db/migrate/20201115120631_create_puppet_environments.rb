class CreatePuppetEnvironments < ActiveRecord::Migration[6.0]
  def change
    create_table :puppet_environments do |t|
      t.string :name

      t.timestamps
    end
  end
end
