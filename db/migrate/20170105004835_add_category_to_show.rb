class AddCategoryToShow < ActiveRecord::Migration
  def change
    add_column :shows, :category_1_id, :integer
    add_column :shows, :category_2_id, :integer
  end
end
