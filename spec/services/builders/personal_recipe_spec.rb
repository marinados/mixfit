require 'rails_helper'

RSpec.describe Builders::PersonalRecipe do
	describe 'self#run' do
		let(:user) { FactoryBot.create(:user) }
		subject(:record) { described_class.run(user).record }
		subject(:record_attrs) { record.attributes.compact.symbolize_keys }

		context 'a user is asking to generate a recipe' do
			let(:expected) do 
				{ user_id: user.id,
					vitamin_c_dosage: 10, 
					vitamin_d3_dosage: 10, 
					iron_dosage: 10 } 
			end

			it 'builds an instance of a new recipe with target values when no meal or activity are recorded' do
				expect(record.new_record?).to be_truthy
				expect(record_attrs).to eq expected
			end

			context 'when already having a meal today' do
				before do
					# vitamin c - 8, d3 - 6, iron - 9
					FactoryBot.create(:food_intake, user: user)
				end

				let(:expected) do 
					{ user_id: user.id,
						vitamin_c_dosage: 2, 
						vitamin_d3_dosage: 4, 
						iron_dosage: 1 } 
				end

				it 'builds an instance of a new recipe with target values' do
					expect(record.new_record?).to be_truthy
					expect(record_attrs).to eq expected
				end

				context 'and also some activity' do
					before do
						# vitamin c - 2, d3 - 3, iron - 1
						FactoryBot.create(:daily_activity, user: user)
					end

					let(:expected) do 
						{ user_id: user.id,
							vitamin_c_dosage: 4, 
							vitamin_d3_dosage: 7, 
							iron_dosage: 2 } 
					end

					it 'builds an instance of a new recipe with target values' do
						expect(record.new_record?).to be_truthy
						expect(record_attrs).to eq expected
					end

					context 'where some values are negative and some exceed the target value' do
						before do
							FactoryBot.create(:daily_activity, user: user, iron_consumption: 10, vitamin_c_consumption: nil, vitamin_d3_consumption: nil)
							FactoryBot.create(:food_intake, user: user, vitamin_d3: 10, iron: nil, vitamin_c: nil)
						end

						let(:expected) do 
							{ user_id: user.id,
								vitamin_c_dosage: 4, # not changed
								vitamin_d3_dosage: 0, # the minimum
								iron_dosage: 10 } # the authorized dosage max
						end

						it 'builds an instance of a new recipe with limited target values' do
							expect(record.new_record?).to be_truthy
							expect(record_attrs).to eq expected
						end
					end

					context 'but a recipe was already generated after these' do
						let!(:old_recipe) { FactoryBot.create(:personal_recipe, expected) }
						
						it 'returns the same recipe instance' do
							expect(record).to eq old_recipe
						end
					end

				end
			end
		end

	end

end