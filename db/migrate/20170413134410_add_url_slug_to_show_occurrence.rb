class AddUrlSlugToShowOccurrence < ActiveRecord::Migration
  def change
    add_column :show_occurrences, :url_slug, :string
  end
end
