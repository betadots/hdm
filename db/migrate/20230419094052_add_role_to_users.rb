class AddRoleToUsers < ActiveRecord::Migration[7.0]
  def up
    add_column :users, :role, :string
    execute "UPDATE users SET role = 'admin' WHERE admin = '1'"
    execute "UPDATE users SET role = 'regular' WHERE admin = '0'"
    change_column :users, :role, :string, null: false, default: "regular"
    remove_column :users, :admin
  end

  def down
    add_column :users, :admin, :boolean, default: false  # rubocop:disable Rails/ThreeStateBooleanColumn
    execute "UPDATE users SET admin = '1' WHERE role = 'admin'"
    change_column :users, :admin, :boolean, default: false, null: false
    remove_column :users, :role
  end
end
