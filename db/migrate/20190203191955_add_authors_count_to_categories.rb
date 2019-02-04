class AddAuthorsCountToCategories < ActiveRecord::Migration[5.2]
  def change
    add_column :categories, :authors_count, :integer
  end
end
