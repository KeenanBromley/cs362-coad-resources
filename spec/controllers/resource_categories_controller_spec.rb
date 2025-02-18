require 'rails_helper'

# PATCH  /resource_categories/:id/activate(.:format)    resource_categories#activate
# PATCH  /resource_categories/:id/deactivate(.:format)  resource_categories#deactivate
# GET    /resource_categories(.:format)                 resource_categories#index
# POST   /resource_categories(.:format)                 resource_categories#create
# GET    /resource_categories/new(.:format)             resource_categories#new
# GET    /resource_categories/:id/edit(.:format)        resource_categories#edit
# GET    /resource_categories/:id(.:format)             resource_categories#show
# PATCH  /resource_categories/:id(.:format)             resource_categories#update
# PUT    /resource_categories/:id(.:format)             resource_categories#update
# DELETE /resource_categories/:id(.:format)             resource_categories#destroy

RSpec.describe ResourceCategoriesController, type: :controller do

  describe "as a logged out user" do
    let(:user) { FactoryBot.create(:user) }

    
  end

  describe "as a logged in user" do 
    let(:user) { FactoryBot.create(:user, :organization_approved) }
    before(:each) { sign_in user }

    
  end

  describe "as an admin" do
    let(:user) { FactoryBot.create(:user, :admin) }
    before(:each) { sign_in user }

    it { expect(get(:index)).to be_successful }
    
    it { expect(get(:new)).to be_successful }

    it { expect(post(:create, params: { resource_category: FactoryBot.attributes_for(:resource_category) })).to redirect_to resource_categories_path }

    it { res_cat = build(:resource_category)
      allow(ResourceCategory).to receive(:new).and_return(res_cat)
      allow(res_cat).to receive(:save).and_return(false)

      post(:create, params: { resource_category: FactoryBot.attributes_for(:resource_category) })
      expect(response).to be_successful
    }
  end

end
