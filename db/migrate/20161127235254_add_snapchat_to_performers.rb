class AddSnapchatToPerformers < ActiveRecord::Migration
  def change
    add_column :performers, :snapchat_url, :string
    add_column :performers, :website_url, :string
  end
end
