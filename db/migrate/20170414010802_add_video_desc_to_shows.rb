class AddVideoDescToShows < ActiveRecord::Migration
  def change
    add_column :shows, :video_description, :text
  end
end
