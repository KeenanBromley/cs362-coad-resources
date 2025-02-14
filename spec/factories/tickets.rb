FactoryBot.define do
  factory :ticket do
    sequence(:name) { |n| "Ticket ##{n}" }
    phone { "+1 555-555-1234" }
    description { "Sample description for the ticket." }
    region
    resource_category
    organization { nil } # Optional association, you can leave it nil or set it to a factory if needed
    closed { false }

    # If you want to specify some sequences for generating unique data
    

    # You can use traits to create different variations of the ticket
    trait :closed do
      closed { true }
    end

    trait :with_organization do
      association :organization, factory: :organization
    end

    trait :open_with_organization do
      closed { false }
      association :organization, factory: :organization
    end
  end
end