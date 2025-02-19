require 'rails_helper'

# POST   /organizations/:id/approve(.:format)   organizations#approve
# POST   /organizations/:id/reject(.:format)    organizations#reject
# GET    /organizations/:id/resources(.:format) organizations#resources
# GET    /organizations(.:format)               organizations#index
# POST   /organizations(.:format)               organizations#create
# GET    /organizations/new(.:format)           organizations#new
# GET    /organizations/:id/edit(.:format)      organizations#edit
# GET    /organizations/:id(.:format)           organizations#show
# PATCH  /organizations/:id(.:format)           organizations#update
# PUT    /organizations/:id(.:format)           organizations#update
# DELETE /organizations/:id(.:format)           organizations#destroy

RSpec.describe OrganizationsController, type: :controller do
  
  describe 'as a logged out user' do 
    let(:user) { FactoryBot.create(:user) }
  
  end

  describe 'as a logged in user' do
    let(:user) { FactoryBot.create(:user) }
    before(:each) { sign_in user }
  end

  describe 'as an admin' do
    let(:user) { FactoryBot.create(:user, :admin) }
    before(:each) { sign_in user }
  end
end
