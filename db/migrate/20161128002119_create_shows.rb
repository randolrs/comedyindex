class CreateShows < ActiveRecord::Migration
  def change
    create_table :shows do |t|
      t.string :name
      t.integer :venue_id
      t.string :website_url
      t.text :about

      t.timestamps null: false
    end
  end
end
