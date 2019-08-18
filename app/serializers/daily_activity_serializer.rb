class DailyActivitySerializer < ApplicationSerializer
  attributes :vitamin_c_consumption, 
  	:vitamin_d3_consumption, 
  	:iron_consumption, 
  	:created_at

  belongs_to :user do |serializer|
	  serializer.username
	end

	def username
	  object.user.name
	end
end