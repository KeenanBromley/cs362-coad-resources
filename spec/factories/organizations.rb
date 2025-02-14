FactoryBot .define do
  factory :organization do
    name { "Organization Name" }
    email { "fakeemail@random.com" }
    phone { "+1 555-555-7890"}
    primary_name { "Name1" }
    secondary_name { "Name2" }
    secondary_phone { "+1 555-555-1234" }
    id { 1 }
  end
end