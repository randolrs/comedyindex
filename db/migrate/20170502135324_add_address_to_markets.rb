class AddAddressToMarkets < ActiveRecord::Migration
  def change
    add_column :markets, :address, :string
    add_column :markets, :latitude, :float
    add_column :markets, :longitude, :float
  end
end
