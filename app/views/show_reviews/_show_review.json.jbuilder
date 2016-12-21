json.extract! show_review, :id, :show_id, :show_occurence_id, :title, :body, :rating, :author_id, :created_at, :updated_at
json.url show_review_url(show_review, format: :json)