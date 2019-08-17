module Api
	module V1
		class DailyActivitiesController < ApiBaseController

			def create
			begin
				builder = ::Builders::DailyActivity.run(current_user, activity_params)
			rescue ::Builders::DailyActivity::InvalidConsumptionValue, 
				::Builders::DailyActivity::InvalidNutrient => e
				return render(json: {error: e.message.to_json}, status: :bad_request)
			end
				activity = builder.record.tap(&:save)
				render(json: activity, serializer: DailyActivitySerializer, status: :created)
			end

			private

			def activity_params
				params.permit(:vitamin_c_consumption, 
					:vitamin_d3_consumption, :iron_consumption)
			end

		end
	end
end