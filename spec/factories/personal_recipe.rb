FactoryBot.define do
  factory :personal_recipe do
  	association :user
    vitamin_c_dosage { 5 }
    vitamin_d3_dosage { 2 }
    iron_dosage { 4 }
  end
end