FactoryBot.define do
  factory :ticket do 
    id { 123 } 
    name { "Ticket name" }
    phone { "+1 555-555-7890" }
    region
    resource_category
    
  end
end