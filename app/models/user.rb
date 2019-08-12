class User < ApplicationRecord
	has_many :daily_activities
	has_many :personal_recipes

	validates :name, 
					presence: true, 
					uniqueness: true, 
					length: { minimum: 5 }
end