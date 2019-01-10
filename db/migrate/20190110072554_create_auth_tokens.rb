class CreateAuthTokens < ActiveRecord::Migration[5.2]
  def change
    create_table :auth_tokens do |t|
      t.references :user, index: true, foreign_key: true

      t.timestamps
    end
  end
end
