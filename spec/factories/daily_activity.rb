FactoryBot.define do
  factory :daily_activity do
    association :user
    vitamin_c_consumption { 2 }
    vitamin_d3_consumption { 3 }
    iron_consumption { 1 }
  end
end