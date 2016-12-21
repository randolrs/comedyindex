class ShowOccurence < ActiveRecord::Base

	belongs_to :show
	has_many :show_reviews
	
end
