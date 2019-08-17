class FoodIntakeSerializer < ActiveModel::Serializer
  attributes :vitamin_c, :vitamin_d3, :iron, :created_at

  belongs_to :user do |serializer|
	  serializer.username
	end

	def username
	  object.user.name
	end
end