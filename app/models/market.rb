class Market < ActiveRecord::Base

	has_many :shows

	has_many :venues

end
