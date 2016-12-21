class CreateShowReviews < ActiveRecord::Migration
  def change
    create_table :show_reviews do |t|
      t.integer :show_id
      t.integer :show_occurence_id
      t.string :title
      t.text :body
      t.decimal :rating
      t.integer :author_id

      t.timestamps null: false
    end
  end
end
