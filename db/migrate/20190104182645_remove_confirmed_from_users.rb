class RemoveConfirmedFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :confirmed
  end
end
