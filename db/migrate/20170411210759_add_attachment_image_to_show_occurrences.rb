class AddAttachmentImageToShowOccurrences < ActiveRecord::Migration
  def self.up
    change_table :show_occurrences do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :show_occurrences, :image
  end
end
