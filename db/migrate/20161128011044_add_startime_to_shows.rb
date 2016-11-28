class AddStartimeToShows < ActiveRecord::Migration
  def change
    add_column :shows, :start_time, :datetime
  end
end
