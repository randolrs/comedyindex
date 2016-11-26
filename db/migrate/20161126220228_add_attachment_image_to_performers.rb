class AddAttachmentImageToPerformers < ActiveRecord::Migration
  def self.up
    change_table :performers do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :performers, :image
  end
end
