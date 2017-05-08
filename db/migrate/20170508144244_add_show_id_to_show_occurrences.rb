class AddShowIdToShowOccurrences < ActiveRecord::Migration
  def change
    add_column :show_occurrences, :show_id, :integer
  end
end
