class PersonalRecipeSerializer < ApplicationSerializer
  attributes :vitamin_c_dosage, 
	  :vitamin_d3_dosage, 
	  :iron_dosage, 
	  :created_at

  belongs_to :user do |serializer|
	  serializer.username
	end

	def username
	  object.user.name
	end
end