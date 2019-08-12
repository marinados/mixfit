class DailyActivity < ApplicationRecord
	belongs_to :user

	VALID_DOSAGE_RANGE = (1..3).freeze

	COLUMNS_TO_VALIDATE = %i(vitamin_c_consumption 
		vitamin_d3_consumption iron_consumption).freeze

	private_constant :VALID_DOSAGE_RANGE

	private_constant :COLUMNS_TO_VALIDATE


	COLUMNS_TO_VALIDATE.each do |attr|
		validates attr, inclusion: { in: VALID_DOSAGE_RANGE }
	end
end