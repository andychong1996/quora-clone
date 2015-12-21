class RenameAnswerVotesVotesCountColumn < ActiveRecord::Migration
	def change
		rename_column :answer_votes, :votes_count, :vote_type
	end
end
