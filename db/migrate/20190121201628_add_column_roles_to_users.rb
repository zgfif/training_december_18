class AddColumnRolesToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :roles, :integer
  end
end
