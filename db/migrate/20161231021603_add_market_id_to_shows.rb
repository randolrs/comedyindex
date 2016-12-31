class AddMarketIdToShows < ActiveRecord::Migration
  def change
    add_column :shows, :market_id, :integer
  end
end
