class AddAboutToShowOccurrences < ActiveRecord::Migration
  def change
    add_column :show_occurrences, :about, :text
  end
end
