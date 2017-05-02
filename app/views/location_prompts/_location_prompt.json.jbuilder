json.extract! location_prompt, :id, :address, :message, :cta_text, :cta_link, :latitude, :longitude, :created_at, :updated_at
json.url location_prompt_url(location_prompt, format: :json)