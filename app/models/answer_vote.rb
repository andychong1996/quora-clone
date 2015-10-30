class AnswerVote < ActiveRecord::Base
	# This is Sinatra! Remember to create a migration!
	validates :user_id, uniqueness: {scope: :answer_id}
end
