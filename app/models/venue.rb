class Venue < ActiveRecord::Base

	has_attached_file :image, 
	:styles => { :medium => "194x194#", :small => "70x70#", :thumb => "30x30#"},
	:default_url => 'missing_person_photo.png',
	:s3_protocol => :https

	validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

	has_many :shows
	belongs_to :market
	belongs_to :user

	geocoded_by :address

	after_validation :geocode, :if => :address_changed?

	reverse_geocoded_by :latitude, :longitude do |obj, results|

		if geo = results.first

			obj.city = geo.city

		end

	end

	after_validation :reverse_geocode


end
