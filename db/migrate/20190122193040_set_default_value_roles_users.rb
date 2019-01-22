class SetDefaultValueRolesUsers < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :roles, :integer, default: 1
  end
end
