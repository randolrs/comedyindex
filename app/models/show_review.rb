class ShowReview < ActiveRecord::Base

	belongs_to :show
	belongs_to :show_occurence
end
