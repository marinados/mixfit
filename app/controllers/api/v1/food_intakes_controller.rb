module Api
	module V1
		class FoodIntakesController < ApiBaseController

			def create
				meal = current_user.food_intakes.build(food_intake_params) 
				if meal.save
					render(json: meal)
				else
					render(json: meal.errors.to_json, status: :bad_request)
				end
			end

			private

			def food_intake_params
				params.permit(*::FoodIntake::COLUMNS_TO_VALIDATE)
			end

		end
	end
end