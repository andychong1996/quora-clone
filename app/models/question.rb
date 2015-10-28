class Question < ActiveRecord::Base
	# This is Sinatra! Remember to create a migration!
	validates :data, presence: true, length: {maximum: 1000}

	has_many :answers
	belongs_to :user
end
