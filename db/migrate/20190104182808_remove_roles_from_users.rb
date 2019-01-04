class RemoveRolesFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :roles
  end
end
