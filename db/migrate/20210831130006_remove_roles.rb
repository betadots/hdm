class RemoveRoles < ActiveRecord::Migration[6.1]
  def change
    remove_reference :users, :role, foreign_key: true, null: false

    drop_table :roles do |t|
      t.string :name
      t.timestamps
    end
  end
end
