require 'rails_helper'

RSpec.describe 'Api V1 Users update request' do
	let(:username) { 'unique_username' }
	
	before do
		FactoryBot.create(:user, name: username)
		put(api_v1_users_path(params))
	end

	context 'all params are valid' do
		let(:params) { { username: username, height: 170, weight: 60 } }

		it { expect(response).to have_http_status(:ok) }
		it { expect(json_response['data']['type']).to eq 'users' } 
	end

	context 'with a missing user' do
		let(:params) { {} }

		it { expect(response).to have_http_status(:unauthorized) }
	end

	context 'with invalid parameters' do
		let(:params) { { username: username, height: 1700, weight: 60 } }

		it { expect(response).to have_http_status(:bad_request) }
		it { expect(json_response['error']).to_not be_empty } 
	end
end