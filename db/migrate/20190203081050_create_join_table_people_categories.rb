class CreateJoinTablePeopleCategories < ActiveRecord::Migration[5.2]
  def change
    create_join_table :people, :categories do |t|
      t.index [:author_id, :category_id]
      t.index [:category_id, :author_id]
    end
  end
end
