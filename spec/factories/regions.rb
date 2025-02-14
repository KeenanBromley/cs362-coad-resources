FactoryBot.define do
  factory :region do
    # Required attribute 'name'
    sequence(:name) { |n| "Region #{n}" }  # Generates unique region names like "Region 1", "Region 2", etc.

   
  end
end