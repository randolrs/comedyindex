class ShowTag < ActiveRecord::Base

	has_many :show_tag_entries

	def self.front_page_tags
		return ShowTag.where(:front_page => true)
	end

	def nearby_show_occurrences(latitude, longitude, start_date, end_date)

		show_collection = Array.new

		nearby_show_occurrences = ShowOccurrence.nearby_show_occurrences(latitude, longitude, start_date, end_date)

		#nearby_shows = Show.nearby([latitude, longitude], 50)

		@nearby_shows = Show.all


		ShowTagEntry.where(:show_tag_id => self.id, :is_active => true).each do |show_tag_entry|

			show = @nearby_shows.where(:id => show_tag_entry.show_id).last
			
			if show #does a show exists that is 1) nearby and 2) has a matching search tag entry  

				ShowOccurrence.nearby_show_occurrences(latitude, longitude, start_date, end_date).where(:schedulable_id => show.id).each do |show_occurrence|

					show_collection << show_occurrence
				
				end

			end

		end

		return show_collection
		
	end

end
