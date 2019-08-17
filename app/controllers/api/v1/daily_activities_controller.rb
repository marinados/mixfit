class DailyActivitiesController < ApiBaseController

	def create
		builder = Builders::DailyActivity.run(current_user, activity_params)
	rescue Builders::DailyActivity::InvalidNutrientConsumptionValue, Builders::DailyActivity::InvalidNutrient => e
		render(status: :bad_request, error: e.message)
	end
		activity = builder.record.save
		render(json: activity.to_json, status: :created)
	end

	private

	def activity_params
		params.permit(:vitamin_c_consumption, 
			:vitamin_d3_consumption, :iron_consumption)
	end

end