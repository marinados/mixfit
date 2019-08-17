class DailyActivity < ApplicationRecord
	belongs_to :user

	scope(:today, lambda do
		where(created_at: 
			Date.today.beginning_of_day..Date.today.end_of_day) 
	end)
end