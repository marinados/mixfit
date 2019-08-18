require 'rails_helper'

RSpec.describe DailyActivitySerializer do
	let(:activity) { FactoryBot.build_stubbed(:daily_activity) }
	let(:expected) do
		{ data:
		  { id: activity.id.to_s,
		    type: 'daily-activities',
		    attributes:
		     	{ 'vitamin-c-consumption': activity.vitamin_c_consumption,
		        'vitamin-d3-consumption': activity.vitamin_d3_consumption,
		      	'iron-consumption': activity.iron_consumption,
		     		'created-at': activity.created_at.to_s },
		   	relationships:
		   		{ user: { data: activity.user.name } }
		  }
		}
	end
	let(:serializer) { described_class.new(activity) }

	subject(:serialized) do 
		ActiveModelSerializers::Adapter.create(serializer).serializable_hash
	end
	
	it 'serializes a daily activity object' do
		expect(serialized).to eq expected
	end 

end