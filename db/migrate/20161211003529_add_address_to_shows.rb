class AddAddressToShows < ActiveRecord::Migration
  def change
    add_column :shows, :address_line_1, :string
    add_column :shows, :address_line_2, :string
    add_column :shows, :city, :string
    add_column :shows, :state_province, :string
    add_column :shows, :country, :string
  end
end
