class AddComicToUsers < ActiveRecord::Migration
  def change
    add_column :users, :is_comic, :boolean
    add_column :users, :is_producer, :boolean
    add_column :users, :is_venue, :boolean
  end
end
