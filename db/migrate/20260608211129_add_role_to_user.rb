class AddRoleToUser < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :role, :string, default: "teacher"
    add_index :users, :role
  end
end
