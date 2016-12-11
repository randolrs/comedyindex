class AddVenueNameToShows < ActiveRecord::Migration
  def change
    add_column :shows, :venue_name, :string
  end
end
