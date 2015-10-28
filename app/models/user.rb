class User < ActiveRecord::Base
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :user_name, presence: true, length: {in: 5..20}
    validates :gender, presence: true
    validates :email, presence: true, uniqueness: true, format: {with: /@/}
    validates :password, presence: true, length: {in: 5..32}

    has_many :questions, :answers
end
