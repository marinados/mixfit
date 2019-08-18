require 'rails_helper'

RSpec.describe PersonalRecipeSerializer do
	let(:recipe) { FactoryBot.build_stubbed(:personal_recipe) }
	let(:expected) do
		{ data:
		  { id: recipe.id.to_s,
		    type: 'personal-recipes',
		    attributes:
		     	{ 'vitamin-c-dosage': recipe.vitamin_c_dosage,
		        'vitamin-d3-dosage': recipe.vitamin_d3_dosage,
		      	'iron-dosage': recipe.iron_dosage,
		     		'created-at': recipe.created_at.to_s },
		   	relationships:
		   		{ user: { data: recipe.user.name } }
		  }
		}
	end
	let(:serializer) { described_class.new(recipe) }

	subject(:serialized) do 
		ActiveModelSerializers::Adapter.create(serializer).serializable_hash
	end
	
	it 'serializes a personal recipe object' do
		expect(serialized).to eq expected
	end 
end