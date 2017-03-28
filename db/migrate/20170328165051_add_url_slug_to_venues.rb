class AddUrlSlugToVenues < ActiveRecord::Migration
  def change
    add_column :venues, :url_slug, :string
  end
end
