class AddApprovedToShowOccurrences < ActiveRecord::Migration
  def change
    add_column :show_occurrences, :approved, :boolean
  end
end
