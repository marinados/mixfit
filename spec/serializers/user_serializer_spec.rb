require 'rails_helper'

RSpec.describe UserSerializer do
	let(:user) { FactoryBot.build_stubbed(:user) }
	let(:expected) do
		{ data:
		  { id: user.id.to_s,
		    type: 'users',
		    attributes:
		     	{ 'name': user.name,
		        'weight': user.weight,
		      	'height': user.height }
		  }
		}
	end
	let(:serializer) { described_class.new(user) }

	subject(:serialized) do 
		ActiveModelSerializers::Adapter.create(serializer).serializable_hash
	end
	
	it 'serializes a user object' do
		expect(serialized).to eq expected
	end 

end