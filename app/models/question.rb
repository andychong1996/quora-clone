class Question < ActiveRecord::Base
	# This is Sinatra! Remember to create a migration!
	validates :data, presence: true, length: {maximum: 1000}

	has_many :answers, dependent: :destroy
	has_many :question_votes
	belongs_to :user
end
