class CreateShowOccurences < ActiveRecord::Migration
  def change
    create_table :show_occurences do |t|
      t.integer :show_id
      t.datetime :start_time

      t.timestamps null: false
    end
  end
end
