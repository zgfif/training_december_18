class CreateJoinTableCategoriesPeople < ActiveRecord::Migration[5.2]
  def change
    create_join_table :categories, :people do |t|
      t.index [:category_id, :person_id]
      t.index [:person_id, :category_id]
    end
  end
end
