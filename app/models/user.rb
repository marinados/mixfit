class User < ApplicationRecord
	has_many :daily_activities
	has_many :personal_recipes
	has_many :food_intakes

	validates :name, 
					presence: true, 
					uniqueness: true, 
					length: { minimum: 5 }

=begin
Since we don't have the info on the precision of
the height mesurement we need, let's assume that we 
have full centimeters as value. Same goes for the weight.
Should we ever support higher precision and/or other measure
units, this would need to be reviewed (and I would make a builder
to support multiple formats).
Just for precaution limiting the height to 250 cm. Didn't come up
with any weight restrictions.
=end
	validates :height, numericality: { less_than_or_equal_to: 250 }, allow_nil: true
	validates :weight, numericality: true, allow_nil: true
end