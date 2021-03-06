class Show < ActiveRecord::Base
	#default_scope :order => 'date ASC'

	has_attached_file :image, 
	:styles => { :medium => "400x400#", :small => "70x70#", :thumb => "30x30#"},
	:default_url => 'show_default.jpg',
	:s3_protocol => :https

	has_many :show_votes

	has_many :show_occurrences

	has_many :show_tag_entries

	acts_as_schedulable :schedule, occurrences: :show_occurrences

	geocoded_by :address

	after_validation :geocode, :if => :address_changed?

	reverse_geocoded_by :latitude, :longitude do |obj, results|

		if geo = results.first

			obj.city = geo.city

			obj.address_street_address = geo.address
    		obj.address_locality = geo.city
		    obj.address_region = geo.state
		    obj.address_country = geo.country
		    obj.address_postal_code = geo.postal_code

		end

	end

	after_validation :reverse_geocode

	self.per_page = 2

	validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

	belongs_to :user

	belongs_to :market

	has_many :show_occurences

	has_many :show_reviews

	belongs_to :venue

	accepts_nested_attributes_for :show_occurences, allow_destroy: true

	def self.default_scope
    	where(["id >= ?",1])
  	end

	def average_rating 

		if self.show_reviews.count > 0
			
			return (self.show_reviews.average(:rating))

		else

			return 0
		end
	end

	


	def self.nearby(latitude, longitude)

  		shows = Show.near([latitude, longitude], 50)

  		return shows

  	end


	def css_rating_code
		
		rating = self.average_rating

		if rating 

			if rating == 0

				return "stars-0"

			elsif (0.01..1.0).include?(rating)

				return "stars-1"

			elsif (1.01..1.5).include?(rating)

				return "stars-1-and-half"

			elsif (1.51..2.0).include?(rating)

				return "stars-2"

			elsif (2.01..2.5).include?(rating)

				return "stars-2-and-half"

			elsif (2.51..3.0).include?(rating)

				return "stars-3"

			elsif (3.01..3.5).include?(rating)

				return "stars-3-and-half"

			elsif (3.51..4.0).include?(rating)

				return "stars-4"

			elsif (4.01..4.5).include?(rating)

				return "stars-4-and-half"

			elsif (4.51..5.0).include?(rating)

				return "stars-5"

			else

				return "stars-0"

			end
		else

			return "stars-0"

		end

	end

	def categories

		categories = Array.new

		if self.category_1_id

			categories << Category.find(self.category_1_id)

		end

		if self.category_2_id

			categories << Category.find(self.category_2_id)

		end

		
		return categories

	end

	
	def display_date

		dates = ShowOccurence.where(:show_id => self.id)

		if dates.count > 0

			future_dates = dates.where("start_time > ? ", Time.now)

			if future_dates.count > 0

				next_date = future_dates.sort_by { |i| i.start_time }
				
				return next_date.first.start_time.strftime("%a, %b %e")

			else

				past_dates = dates.where("start_time < ? ", Time.now)

				most_recent_date = past_dates.sort_by { |i| i.start_time }
				
				return most_recent_date.first.start_time.strftime("%a, %b %e")
			end
		else

			return ""

		end
	end

	def next_occurrence

		if self.remaining_show_occurrences.count > 0
			
			return self.remaining_show_occurrences.first.date
		else
			return "Date TBD"
		end

	end

	def has_tag(show_tag_id)

		return ShowTagEntry.where(:show_id => self.id, :show_tag_id => show_tag_id, :is_active => true).exists?

	end

	def next_occurrence_date

		if self.remaining_show_occurrences.count > 0
			
			return self.remaining_show_occurrences.first.date.strftime("%A, %b %e, %Y")
		else
			return "Date TBD"
		end
	end

	def next_occurrence_time

		if self.remaining_show_occurrences.count > 0
			
			return self.remaining_show_occurrences.first.date.strftime("%l:%M%P")
		else
			return "Time TBD"
		end
	end

	def display_time

		dates = ShowOccurence.where(:show_id => self.id)

		if dates.count > 0

			future_dates = dates.where("start_time > ? ", Time.now)

			if future_dates.count > 0

				next_date = future_dates.sort_by { |i| i.start_time }
				
				return next_date.first.start_time.strftime("%l:%M %p")

			else

				past_dates = dates.where("start_time < ? ", Time.now)

				most_recent_date = past_dates.sort_by { |i| i.start_time }
				
				return most_recent_date.first.start_time.strftime("%l:%M %p")
			end
		else

			return ""

		end
	end



	def more_dates

		dates = ShowOccurence.where(:show_id => self.id)

		if dates.count > 0

			future_dates = dates.where("start_time > ? ", Time.now)

			if future_dates.count > 0

				future_dates_sorted = future_dates.sort_by { |i| i.start_time }
				
				future_dates_sorted.shift

				return future_dates_sorted

			else

				return nil

			end

		else

			return nil

		end
	end



end
