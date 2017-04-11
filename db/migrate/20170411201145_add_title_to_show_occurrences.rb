class AddTitleToShowOccurrences < ActiveRecord::Migration
  def change
    add_column :show_occurrences, :title, :string
  end
end
