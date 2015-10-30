class CreateQuestionVote < ActiveRecord::Migration
	def change
		create_table (:question_votes) do |t|
			t.integer :user_id
			t.integer :question_id
			t.integer :votes_count
		end
	end
end
