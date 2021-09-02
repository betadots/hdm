class AddAdminFlagToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :admin, :boolean, null: false, default: false

    reversible do |dir|
      dir.up do
        execute "UPDATE users SET admin = EXISTS(SELECT id FROM roles WHERE users.role_id = roles.id AND roles.name = 'Admin')"
      end
    end
  end
end
