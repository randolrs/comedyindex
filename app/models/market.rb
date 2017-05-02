class Market < ActiveRecord::Base

	has_many :shows

	has_many :venues

	geocoded_by :address

	after_validation :geocode, :if => :address_changed?

	reverse_geocoded_by :latitude, :longitude
	

end
