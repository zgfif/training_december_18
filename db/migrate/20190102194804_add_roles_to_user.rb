class AddRolesToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :roles, :integer, default: 1
  end
end
