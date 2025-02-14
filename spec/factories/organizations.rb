FactoryBot.define do
  factory :organization do
    # Required attributes
    sequence(:email) { |n| "organization#{n}@example.com" }
    sequence(:name) { |n| "Organization #{n}" }
    phone { "1234567890" }
    primary_name { "John Doe" }
    secondary_name { "Jane Doe" }
    secondary_phone { "0987654321" }
    
    # Enum attributes with default values
    status { :submitted }
    transportation { :yes }

    # Optional attributes (for agreements)
    agreement_one { true }
    agreement_two { true }
    agreement_three { false }
    agreement_four { true }
    agreement_five { false }
    agreement_six { true }
    agreement_seven { false }
    agreement_eight { true }

    # Associations (assuming factories for users and resource_categories are defined)
    # You can also use `association :model` if you want to automatically create associated models
    # and specify the number of associations using `create_list`.

    # For example, creating a user and associating it with the organization
    # after_create: :create_users 
    after(:create) do |organization|
      create_list(:user, 2, organization: organization) # Creates 2 associated users
    end

    # Optional associations for tickets and resource_categories (can be overridden in tests)
    # create_list can be used to create associated records as well.
    after(:create) do |organization|
      create_list(:ticket, 2, organization: organization) # Creates 2 associated tickets
      organization.resource_categories << create(:resource_category) # Associate with a resource category
    end

    # Validations are checked on creation, no need to add validation specifics here.
    # However, you can add sequences if you need dynamic values for attributes like email or name
    
  end
end