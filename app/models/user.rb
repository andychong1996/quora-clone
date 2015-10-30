class User < ActiveRecord::Base
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :user_name, presence: true, length: {in: 5..20}
    validates :gender, presence: true
    validates :email, presence: true, uniqueness: true, format: {with: /@/}
    validates :password, presence: true, length: {in: 5..32}

    has_many :questions
    has_many :answers
    has_many :answer_votes
    has_many :question_votes

    def self.authenticate(email, password)
      return nil unless user = User.find_by(email: email)

      if user.password == password
        return user
      else
        return nil
      end
    end

end
