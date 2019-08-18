require 'rails_helper'

RSpec.describe 'Api V1 Personal Recipes create request' do
	let(:username) { 'unique_username' }
	
	before do
		FactoryBot.create(:user, name: username)
		post(api_v1_personal_recipes_today_path, params: params)
	end

	context 'all params are valid' do
		let(:params) do 
			{ username: username }
		end

		it { expect(response).to have_http_status(:created) }
		it { expect(json_response['data']['type']).to eq 'personal-recipes' } 
	end

	context 'with a missing user' do
		let(:params) do
			{ }
		end

		it { expect(response).to have_http_status(:unauthorized) }
	end
end