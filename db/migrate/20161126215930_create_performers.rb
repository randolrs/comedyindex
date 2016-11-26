class CreatePerformers < ActiveRecord::Migration
  def change
    create_table :performers do |t|
      t.string :name
      t.string :bio
      t.string :city
      t.string :country
      t.string :twitter_url
      t.string :facebook_url
      t.string :instagram_url
      t.string :youtube_url
      t.string :video_url

      t.timestamps null: false
    end
  end
end
