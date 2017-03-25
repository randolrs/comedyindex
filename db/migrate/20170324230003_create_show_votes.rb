class CreateShowVotes < ActiveRecord::Migration
  def change
    create_table :show_votes do |t|
      t.integer :show_id
      t.integer :show_occurrence_id
      t.integer :venue_id
      t.boolean :is_up
      t.boolean :is_down

      t.timestamps null: false
    end
  end
end
