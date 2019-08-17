class PersonalRecipesController < ApiBaseController 
	
	def create
		builder = ::Builders::PersonalRecipe.run(current_user)
		if builder.record.persisted? || builder.record.save
			render(json: builder.record.to_json)
		else
			render(json: builder.record.errors.to_json, status: :bad_request)

		end
	end

	def index
	end

end