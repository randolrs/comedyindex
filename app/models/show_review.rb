class ShowReview < ActiveRecord::Base

	belongs_to :show
	belongs_to :show_occurence
	belongs_to :user
end
