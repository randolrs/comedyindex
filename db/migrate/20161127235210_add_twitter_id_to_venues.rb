class AddTwitterIdToVenues < ActiveRecord::Migration
  def change
    add_column :venues, :twitter_url, :string
    add_column :venues, :instagram_url, :string
    add_column :venues, :facebook_url, :string
    add_column :venues, :youtube_url, :string
    add_column :venues, :snapchat_url, :string
    add_column :venues, :website_url, :string
  end
end
