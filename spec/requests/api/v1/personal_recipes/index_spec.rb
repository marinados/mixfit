require 'rails_helper'

RSpec.describe 'Api V1 Personal Recipes index request' do
	let(:username) { 'unique_username' }
	let!(:user) { FactoryBot.create(:user, name: username) }
	
	let(:params) do 
		{ username: username }
	end

	context 'params are valid but no recipes are found' do
		before do
			get(api_v1_personal_recipes_path, params: params)
		end

		it { expect(response).to have_http_status(:ok) }
		it { expect(json_response['data']).to be_empty } 
	end

	context 'params are valid, recipes exist' do
		let!(:recipes) do
			FactoryBot.create_list(:personal_recipe, 2, user: user)
		end

		before do
			get(api_v1_personal_recipes_path, params: params)
		end

		it { expect(response).to have_http_status(:ok) }
		it { expect(json_response['data'].map { |d| d['type'] }.uniq).to eq ['personal-recipes'] } 
		it { expect(json_response['data'].count).to eq 2} 
		it { expect(json_response['links']).to_not be_empty } 

		context 'with pagination params' do
			let(:params) do
				{ username: username, page: 2, per_page: 1 }
			end

			it { expect(response).to have_http_status(:ok) }
			it { expect(json_response['data'].count).to eq 1} 
			it { expect(json_response['data'].first['id']).to eq recipes.last.id.to_s}
		end
	end

	context 'with a missing user' do
		before do
			get(api_v1_personal_recipes_path, params: params)
		end

		let(:params) { {} }

		it { expect(response).to have_http_status(:unauthorized) }
	end
end