class FoodIntake < ApplicationRecord
	belongs_to :user

	VALID_DOSAGE_RANGE = (4..10).freeze

	COLUMNS_TO_VALIDATE = %i(vitamin_c vitamin_d3 iron).freeze

	private_constant :VALID_DOSAGE_RANGE

	private_constant :COLUMNS_TO_VALIDATE


	COLUMNS_TO_VALIDATE.each do |attr|
		validates attr, 
							presence: true,
							inclusion: { in: VALID_DOSAGE_RANGE }
	end
end