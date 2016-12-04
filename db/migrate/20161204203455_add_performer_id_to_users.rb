class AddPerformerIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :performer_id, :integer
  end
end
