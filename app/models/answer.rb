class Answer < ActiveRecord::Base
	# This is Sinatra! Remember to create a migration!
	validates :data, presence:true#, length: {maximum: 1000}
	has_many :answer_votes
	belongs_to :user
	belongs_to :question
end
