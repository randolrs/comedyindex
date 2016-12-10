class AddUrlSlugToShows < ActiveRecord::Migration
  def change
    add_column :shows, :url_slug, :string
  end
end
