class CreateLocationPrompts < ActiveRecord::Migration
  def change
    create_table :location_prompts do |t|
      t.string :address
      t.text :message
      t.string :cta_text
      t.string :cta_link
      t.float :latitude
      t.float :longitude

      t.timestamps null: false
    end
  end
end
