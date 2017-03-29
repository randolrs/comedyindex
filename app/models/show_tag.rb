class ShowTag < ActiveRecord::Base

	def self.front_page_tags
		return ShowTag.where(:front_page => true)
	end

end
