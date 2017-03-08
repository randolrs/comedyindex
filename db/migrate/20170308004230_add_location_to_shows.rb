class AddLocationToShows < ActiveRecord::Migration
  def change
    add_column :shows, :address, :string
    add_column :shows, :latitude, :float
    add_column :shows, :longitude, :float
  end
end
