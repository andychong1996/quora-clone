class CreateQuestions < ActiveRecord::Migration
	def change
		create_table (:questions) do |t|
			t.integer :user_id
			t.string :data
			t.timestamps

		end
	end
end
