module Api
	module V1
		class UsersController < ApiBaseController 
			
			def update
				current_user.attributes = user_params
				if current_user.save
					render(json: current_user.to_json)
				else
					render(json: current_user.errors.to_json, status: :bad_request)
				end
			end

			private

			def user_params
				params.permit(:height, :weight)
			end

		end
	end
end