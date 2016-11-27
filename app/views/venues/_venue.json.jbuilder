json.extract! venue, :id, :city_id, :address_line_1, :address_line_2, :name, :created_at, :updated_at
json.url venue_url(venue, format: :json)