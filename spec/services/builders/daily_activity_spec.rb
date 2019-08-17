require 'rails_helper'

RSpec.describe Builders::DailyActivity do
	describe 'self#run' do
		subject(:run) { described_class.run(user, options) }
		let(:user) { nil }
		let(:options) { {} }

		context 'when the arguments are not valid' do
			context 'and no user is specified' do
				it 'raises the MissingUser error' do
					expect { run }.to raise_error(described_class::MissingUser)
				end
			end

			context 'and the options list contains no authorized values' do
				let(:user) { double(User) }

				it 'raises the InvalidNutrient error' do
					expect { run }.to raise_error(described_class::InvalidNutrient)
				end
			end

			context 'and the options list contains no authorized values for authorized nutrients' do
				let(:user) { double(User) }
				let(:options) { { vitamin_c_consumption: 50 } }

				it 'raises the InvalidConsumptionValue error' do
					expect { run }.to raise_error(described_class::InvalidConsumptionValue)
				end
			end

			context 'the arguments are fine' do
				let(:user) { FactoryBot.build_stubbed(:user) }
				let(:options) { { vitamin_c_consumption: -2 } }

				let(:expected) { { user_id: user.id }.merge(options.transform_values {|v| v.abs }) }

				it 'builds a record of DailyActivity with the right attributes' do
					expect(run.record).to be_an_instance_of(DailyActivity)
					expect(run.record.attributes.compact.symbolize_keys).to eq expected
				end
			end

		end
	end
end