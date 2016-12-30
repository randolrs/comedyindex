class Show < ActiveRecord::Base

	has_attached_file :image, 
	:styles => { :medium => "400x400#", :small => "70x70#", :thumb => "30x30#"},
	:default_url => 'missing_person_photo.png',
	:s3_protocol => :https

	validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

	belongs_to :user

	has_many :show_occurences

	has_many :show_reviews

	accepts_nested_attributes_for :show_occurences, allow_destroy: true

	def average_rating 

		if self.show_reviews.count > 0
			
			return (self.show_reviews.average(:rating)*2).round / 2

		else

			return "N/A"
		end
	end
	
	def display_date

		dates = ShowOccurence.where(:show_id => self.id)

		if dates.count > 0

			future_dates = dates.where("start_time > ? ", Time.now)

			if future_dates.count > 0

				next_date = future_dates.sort_by { |i| i.start_time }
				
				return next_date.first.start_time.strftime("%A, %b %e, %Y @ %l:%M %p")

			else

				past_dates = dates.where("start_time < ? ", Time.now)

				most_recent_date = past_dates.sort_by { |i| i.start_time }
				
				return most_recent_date.first.start_time.strftime("%A, %b %e, %Y @ %l:%M %p")
			end
		else

			return ""

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
