class AddReasonToShows < ActiveRecord::Migration
  def change
    add_column :shows, :reason_we_recommend, :text
    add_column :shows, :video_url, :string
  end
end
