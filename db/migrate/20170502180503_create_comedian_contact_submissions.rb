class CreateComedianContactSubmissions < ActiveRecord::Migration
  def change
    create_table :comedian_contact_submissions do |t|
      t.string :email
      t.string :twitter_url
      t.string :facebook_url

      t.timestamps null: false
    end
  end
end
