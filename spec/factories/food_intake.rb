FactoryBot.define do
  factory :food_intake do
  	association :user
    vitamin_c { 8 }
    vitamin_d3 { 6 }
    iron { 9 }
  end
end