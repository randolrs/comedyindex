class ShowReview < ActiveRecord::Base

	belongs_to :show
	belongs_to :show_occurence
	belongs_to :user

	def css_rating_code
		
		rating = self.rating

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

end
