class CreateShowTagEntries < ActiveRecord::Migration
  def change
    create_table :show_tag_entries do |t|
      t.integer :show_id
      t.integer :show_tag_id

      t.timestamps null: false
    end
  end
end
