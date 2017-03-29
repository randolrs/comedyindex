class CreateShowTags < ActiveRecord::Migration
  def change
    create_table :show_tags do |t|
      t.string :name
      t.integer :parent_tag_id

      t.timestamps null: false
    end
  end
end
