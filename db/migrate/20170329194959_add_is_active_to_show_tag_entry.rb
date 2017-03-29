class AddIsActiveToShowTagEntry < ActiveRecord::Migration
  def change
    add_column :show_tag_entries, :is_active, :boolean
  end
end
