FactoryBot.define do
  factory :resource_category do
    # Required attribute 'name'
    sequence(:name) { |n| "Resource Category #{n}" } # Generates unique names like "Resource Category 1"

    # Default active state
    active { true }

    # Traits for active/inactive states
    trait :inactive do
      active { false }
    end

  end

end