class QuestionVote < ActiveRecord::Base
	# This is Sinatra! Remember to create a migration!
	validates :user_id, uniqueness: {scope: :question_id}
end
