class AddProducerIdToShows < ActiveRecord::Migration
  def change
    add_column :shows, :producer_id, :integer
  end
end
