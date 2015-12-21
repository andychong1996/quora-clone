class RenameQuestionVotesVotesCountColumn < ActiveRecord::Migration
	def change
		rename_column :question_votes, :votes_count, :vote_type
	end
end
