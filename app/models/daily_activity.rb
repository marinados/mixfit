class DailyActivity < ApplicationRecord
	belongs_to :user

	scope(:today, lambda do
		where(created_at: 
			Date.current.beginning_of_day..Date.current.end_of_day) 
	end)
end