class Show < ActiveRecord::Base

	has_attached_file :image, 
	:styles => { :medium => "800x400#", :small => "70x70#", :thumb => "30x30#"},
	:default_url => 'missing_person_photo.png',
	:s3_protocol => :https

	validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

	belongs_to :user

	has_many :show_occurences

	accepts_nested_attributes_for :show_occurences, allow_destroy: true
	
	def display_date

		dates = ShowOccurence.where(:show_id => self.id)

		if dates.count > 0

			future_dates = dates.where("start_time > ? ", Time.now)

			if future_dates.count > 0

				next_date = future_dates.sort_by { |i| i.start_time }
				
				return next_date.first.start_time.strftime("%A, %b %e, %Y")

			else

				past_dates = dates.where("start_time < ? ", Time.now)

				most_recent_date = past_dates.sort_by { |i| i.start_time }
				
				return most_recent_date.first.start_time.strftime("%A, %b %e, %Y")
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
