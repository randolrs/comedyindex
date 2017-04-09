class AddAddressDetailsToShows < ActiveRecord::Migration
  def change
    add_column :shows, :address_street_address, :string
    add_column :shows, :address_locality, :string
    add_column :shows, :address_region, :string
    add_column :shows, :address_country, :string
    add_column :shows, :address_postal_code, :string
  end
end
