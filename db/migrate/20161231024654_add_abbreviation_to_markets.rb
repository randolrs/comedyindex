class AddAbbreviationToMarkets < ActiveRecord::Migration
  def change
    add_column :markets, :short_name, :string
  end
end
