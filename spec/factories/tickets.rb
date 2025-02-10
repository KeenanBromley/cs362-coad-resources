FactoryBot.define do
  factory :ticket do 
    id { 123 } 
    name { "Ticket name" }
    phone { "123-456-7890" }
    region_id { 123 }
    resource_category_id { 123 } 
    
  end
end