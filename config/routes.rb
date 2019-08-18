Rails.application.routes.draw do
	namespace :api do
		namespace :v1 do
			put 'users', to: 'users#update'
			resource :food_intakes, only: %i(create)
			resource :daily_activities, only: %i(create)
			post 'personal_recipes/today', to: 'personal_recipes#create'
			resources :personal_recipes, only: %i(index)
		end
	end
end
