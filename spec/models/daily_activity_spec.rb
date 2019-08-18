require 'rails_helper'

RSpec.describe DailyActivity do 
	describe 'self#today' do
		let!(:todays_activity) { FactoryBot.create(:daily_activity) }
		let!(:old_activity) do
			FactoryBot.create(:daily_activity, created_at: 3.days.ago)
		end

		subject { described_class.today }

		it 'selects only today\'s activities' do
			expect(subject).to match_array([todays_activity])
		end
	end
end