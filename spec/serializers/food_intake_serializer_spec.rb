require 'rails_helper'

RSpec.describe FoodIntakeSerializer do
	let(:meal) { FactoryBot.build_stubbed(:food_intake) }
	let(:expected) do
		{ data:
		  { id: meal.id.to_s,
		    type: 'food-intakes',
		    attributes:
		     	{ 'vitamin-c': meal.vitamin_c,
		        'vitamin-d3': meal.vitamin_d3,
		      	'iron': meal.iron,
		     		'created-at': meal.created_at.to_s },
		   	relationships:
		   		{ user: { data: meal.user.name } }
		  }
		}
	end
	let(:serializer) { described_class.new(meal) }

	subject(:serialized) do 
		ActiveModelSerializers::Adapter.create(serializer).serializable_hash
	end
	
	it 'serializes a food intake object' do
		expect(serialized).to eq expected
	end 

end