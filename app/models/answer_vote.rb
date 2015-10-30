class AnswerVote < ActiveRecord::Base

	belongs_to :user
	belongs_to :answer
	# This is Sinatra! Remember to create a migration!
	validates :user_id, uniqueness: {scope: :answer_id}

end
