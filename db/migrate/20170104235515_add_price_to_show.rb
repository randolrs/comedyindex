class AddPriceToShow < ActiveRecord::Migration
  def change
    add_column :shows, :price, :decimal
  end
end
