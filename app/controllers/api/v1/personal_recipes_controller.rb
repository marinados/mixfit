module Api
	module V1
		class PersonalRecipesController < ApiBaseController 
	
			def create
				builder = ::Builders::PersonalRecipe.run(current_user)
				if builder.record.persisted? || builder.record.tap(&:save)
					render(json: builder.record, serializer: PersonalRecipeSerializer, status: :created)
				else
					render(json: builder.record.errors.to_json, status: :bad_request)
				end
			end

			def index
				page = params[:page] || 1
				per_page = params[:per_page] || DEFAULT_PER_PAGE
				recipes = current_user.personal_recipes.page(page).per(per_page)
				render(json: recipes, each_serializer: PersonalRecipeSerializer)
			end

		end
	end
end