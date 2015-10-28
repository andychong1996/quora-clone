class Answer < ActiveRecord::Base
	# This is Sinatra! Remember to create a migration!
	validates :data, presence:true length: {maximum: 1000}

	belongs_to :user, :question
end
