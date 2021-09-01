class CreateGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :groups do |t|
      t.string :name, index: {unique: true}
      t.string :restrict, null: false, default: "environment"
      t.text :rules

      t.timestamps
    end
  end
end
