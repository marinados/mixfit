require 'rails_helper'

RSpec.describe 'Api V1 Food Intake create request' do
	let(:username) { 'unique_username' }
	
	before do
		FactoryBot.create(:user, name: username)
		post(api_v1_food_intakes_path, params: params)
	end

	context 'all params are valid' do
		let(:params) do 
			{
				username: username,
				vitamin_c: 5,
				vitamin_d3: 5,
				iron: 5
			}
		end

		it { expect(response).to have_http_status(:created) }
		it { expect(json_response['data']['type']).to eq 'food-intakes' } 
	end

	context 'with a missing user' do
		let(:params) do
			{ 
				vitamin_c: 5,
				vitamin_d3: 5,
				iron: 5
			}
		end

		it { expect(response).to have_http_status(:unauthorized) }
	end

	context 'with invalid parameters' do
		let(:params) do
			{ 
				username: username,
				vitamin_c: 20,
				vitamin_d34: 1,
				iron: 3
			}
		end

		it { expect(response).to have_http_status(:bad_request) }
		it { expect(json_response['error']).to_not be_empty } 
	end
end