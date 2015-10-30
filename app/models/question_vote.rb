class QuestionVote < ActiveRecord::Base
		belongs_to :user
		belongs_to :question
	# This is Sinatra! Remember to create a migration!
	validates :user_id, uniqueness: {scope: :question_id}
end
