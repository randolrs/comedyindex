class AddStateProvinceToVenues < ActiveRecord::Migration
  def change
    add_column :venues, :state_province, :string
    add_column :venues, :market_id, :integer
  end
end
