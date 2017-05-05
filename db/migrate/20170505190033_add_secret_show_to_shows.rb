class AddSecretShowToShows < ActiveRecord::Migration
  def change
    add_column :shows, :is_secret_show, :boolean
  end
end
