class AddFrontPageToShowTags < ActiveRecord::Migration
  def change
    add_column :show_tags, :front_page, :boolean
    add_column :show_tags, :url_slug, :string
  end
end
