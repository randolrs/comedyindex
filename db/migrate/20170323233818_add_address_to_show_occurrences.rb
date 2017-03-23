class AddAddressToShowOccurrences < ActiveRecord::Migration
  def change
    add_column :show_occurrences, :address, :string
    add_column :show_occurrences, :latitude, :float
    add_column :show_occurrences, :longitude, :float
  end
end
