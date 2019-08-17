module Builders
	class DailyActivity

		class MissingUser < StandardError; end
		class InvalidNutrient < StandardError; end
		class InvalidNutrientConsumptionValue < StandardError; end

		def self.run(user, options = {})
			new(user, options).run
		end

		AUTHORIZED_NUTRIENTS = %i(vitamin_c_consumption 
			vitamin_d3_consumption iron_consumption).freeze

		AUTHORIZED_CONSUMPTION_VALUES = (-3..-1).freeze

		MISSING_USER_MSG = 'A user must be specified'.freeze
		INVALID_NUTRIENT_MSG = 
			"The nutrient list can only include the following 
			parameters: #{AUTHORIZED_NUTRIENTS.join(', ')}.".freeze
		INVALID_CONSUMPTION_MSG = "The nutrient consumption can be 
			represented by a negative value within 
			#{AUTHORIZED_CONSUMPTION_VALUES}.".freeze

		private_constant :AUTHORIZED_NUTRIENTS
		private_constant :AUTHORIZED_CONSUMPTION_VALUES
		private_constant :MISSING_USER_MSG
		private_constant :INVALID_NUTRIENT_MSG
		private_constant :INVALID_CONSUMPTION_MSG

		attr_reader :record

		def initialize(user, options)
			@user = user
			@options = options
		end

		def run
			validate_parameters
			@record = @user.daily_activities.build(nutrients_consumption)
		end

		private

		def validate_parameters
			raise MissingUser, MISSING_USER_MSG if @user.nil?
			raise InvalidNutrient, INVALID_NUTRIENT_MSG if invalid_nutrients_list?
			raise InvalidNutrientConsumptionValue, 
				INVALID_CONSUMPTION_MSG if invalid_nutrient_consumption_value?
		end

		# Verifying that the options hash only contains the 
		# authorized values and has at least one of them
		def invalid_nutrients_list?
			(AUTHORIZED_NUTRIENTS & @options.keys).empty? ||
				(@options.keys - AUTHORIZED_NUTRIENTS).any?
		end

		# Checking if all the values are within the authorized
		# range
		def invalid_nutrient_consumption_value?
			nutrients_consumption.values.all? do |v| 
				v.in?(AUTHORIZED_CONSUMPTION_VALUES)
			end
		end

		# We would not want to store negative values in the DB
		def nutrients_consumption
			@_nutrients_consumption ||=
				@options.slice(*AUTHORIZED_NUTRIENTS).
				compact.transform_values { |v| v.abs }
		end
	end
end
