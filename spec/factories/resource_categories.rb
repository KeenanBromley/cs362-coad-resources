FactoryBot .define do
  factory :resource_category do 
    name { "Resource Category" }
    active { true }

    trait :inactive do
      active { false }
    end
  end
end