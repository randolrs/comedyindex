class LocationPrompt < ActiveRecord::Base

	geocoded_by :address

	after_validation :geocode, :if => :address_changed?

	reverse_geocoded_by :latitude, :longitude

end
