require 'rails_helper'

RSpec.describe 'Api V1 Daily Activity create request' do
	let(:username) { 'unique_username' }
	
	before do
		FactoryBot.create(:user, name: username)
		post(api_v1_daily_activities_path, params: params)
	end

	context 'all params are valid' do
		let(:params) do 
			{
				username: username,
				vitamin_c_consumption: 2,
				vitamin_d3_consumption: 1,
				iron_consumption: 3
			}
		end

		it { expect(response).to have_http_status(:created) }
		it { expect(json_response['data']['type']).to eq 'daily-activities' } 
	end

	context 'with a missing user' do
		let(:params) do
			{ 
				vitamin_c_consumption: 2,
				vitamin_d3_consumption: 1,
				iron_consumption: 3
			}
		end

		it { expect(response).to have_http_status(:unauthorized) }
	end

	context 'with invalid parameters' do
		let(:params) do
			{ 
				username: username,
				vitamin_c_consumption: 20,
				vitamin_d34_consumption: 1,
				iron_consumption: 3
			}
		end

		it { expect(response).to have_http_status(:bad_request) }
		it { expect(json_response['error']).to_not be_empty }
	end
end