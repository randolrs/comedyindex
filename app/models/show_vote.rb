class ShowVote < ActiveRecord::Base

	belongs_to :show

	belongs_to :show_occurrence

	belongs_to :user

	def upvote

		self.update(:is_up => true, :is_down => nil)

	end

	def downvote
		self.update(:is_down => true, :is_up => nil)
	end
end
