class RenameConfirmationTokenToPasswordConfirmation < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :confirmation_token, :password_confirmation
  end
end
