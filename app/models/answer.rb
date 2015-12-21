class Answer < ActiveRecord::Base
	# This is Sinatra! Remember to create a migration!
	validates :data, presence:true
	has_many :answer_votes, dependent: :destroy
	belongs_to :user
	belongs_to :question
end
