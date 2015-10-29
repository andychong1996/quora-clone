class RemoveAnswersVoteCol < ActiveRecord::Migration
	def change
		remove_column :answers, :vote
	end
end
