class AddMarketToUsers < ActiveRecord::Migration
  def change
    add_column :users, :default_market_id, :integer
  end
end
