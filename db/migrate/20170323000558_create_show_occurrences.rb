class CreateShowOccurrences < ActiveRecord::Migration
  def self.up
    create_table :show_occurrences do |t|

      t.references :schedulable, polymorphic: true
      t.datetime :date

      t.timestamps
      
    end
  end

  def self.down
    drop_table :show_occurrences
  end
end