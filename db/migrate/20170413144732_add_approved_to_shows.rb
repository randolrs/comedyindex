class AddApprovedToShows < ActiveRecord::Migration
  def change
    add_column :shows, :approved, :boolean
  end
end
