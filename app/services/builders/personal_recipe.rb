module Builders
	class PersonalRecipe

		MINIMUM_DOSAGE = 0
		TARGET_VALUE = 10
		NUTRIENTS_TO_CALCULATE = %i(vitamin_c 
			vitamin_d3 iron).freeze

		private_constant :MINIMUM_DOSAGE
		private_constant :TARGET_VALUE
		private_constant :NUTRIENTS_TO_CALCULATE

		attr_reader :record 

		def self.run(user)
			new(user).run
		end

		def initialize(user)
			@user = user
			@meals = @user.food_intakes.today
			@activities = @user.daily_activities.today
			@last_generated_recipe = @user.personal_recipes.today.last
		end

		def run
			@record = if same_as_last_recipe? 
				@last_generated_recipe 
			else
				@user.personal_recipes.build(recipe_attributes)
			end
			self
		end

		private

		def same_as_last_recipe?
			return false unless @last_generated_recipe
			@last_generated_recipe.slice(
				*NUTRIENTS_TO_CALCULATE.map {|n| "#{n}_dosage"}
			) == recipe_attributes
		end

		def recipe_attributes
			@_recipe_attrs ||= get_recipe_attributes
		end

		def get_recipe_attributes
			attributes = {}
			NUTRIENTS_TO_CALCULATE.map do |nutrient|
				attributes["#{nutrient}_dosage"] = 
					calculate_dosage(nutrient)
			end
			attributes
		end

		def calculate_dosage(nutrient)
			value = TARGET_VALUE - current_level(nutrient)
			return value if value.in?(MINIMUM_DOSAGE..TARGET_VALUE)
			return MINIMUM_DOSAGE if value <= MINIMUM_DOSAGE
			TARGET_VALUE
		end

		def current_level(nutrient)
			@meals.pluck(nutrient).compact.inject(:+).to_i - 
				@activities.pluck("#{nutrient}_consumption").
				compact.inject(:+).to_i
		end

	end
end