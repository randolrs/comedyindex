class AddReasonToShowOccurrences < ActiveRecord::Migration
  def change
    add_column :show_occurrences, :video_url, :string
    add_column :show_occurrences, :video_description, :text
    add_column :show_occurrences, :reason_we_recommend, :text
  end
end
