class AddCityToVenues < ActiveRecord::Migration
  def change
    add_column :venues, :city, :string
  end
end
