FactoryBot.define do
  factory :user do 
    email { "fake@fakeemail.com" }
    password { "fakepassword" }

    trait :admin do
      role { :admin }
    end

    trait :organization do
      role { :organization}
    end 
  end
end