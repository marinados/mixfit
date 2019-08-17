class FoodIntake < ApplicationRecord
	
	belongs_to :user

	VALID_DOSAGE_RANGE = (4..10).freeze

	COLUMNS_TO_VALIDATE = %i(vitamin_c vitamin_d3 iron).freeze

	private_constant :VALID_DOSAGE_RANGE

	COLUMNS_TO_VALIDATE.each do |attr|
		validates attr, 
							allow_nil: true,
							inclusion: { in: VALID_DOSAGE_RANGE }
	end

	scope(:today, lambda do
			where(created_at: 
				Date.today.beginning_of_day..Date.today.end_of_day) 
		end)
end