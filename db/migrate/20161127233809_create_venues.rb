class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues do |t|
      t.integer :city_id
      t.string :address_line_1
      t.string :address_line_2
      t.string :name

      t.timestamps null: false
    end
  end
end
