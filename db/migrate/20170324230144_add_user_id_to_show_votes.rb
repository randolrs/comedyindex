class AddUserIdToShowVotes < ActiveRecord::Migration
  def change
    add_column :show_votes, :user_id, :integer
  end
end
