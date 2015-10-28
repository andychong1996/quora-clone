class CreateAnswers < ActiveRecord::Migration
	def change
		create_table (:answers) do |t|
			t.integer :user_id
			t.integer :question_id
			t.string :data
			t.string :vote
			t.timestamps
		end
	end
end
