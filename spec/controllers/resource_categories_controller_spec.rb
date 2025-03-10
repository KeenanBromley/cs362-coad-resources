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
  let(:resource_category) { FactoryBot.create(:resource_category) }

  describe "as a logged out user" do
    it "redirects to login for index" do
      get :index
      expect(response).to redirect_to(new_user_session_path)
    end

    it "redirects to login for show" do
      get :show, params: { id: resource_category.id }
      expect(response).to redirect_to(new_user_session_path)
    end

    it "redirects to login for new" do
      get :new
      expect(response).to redirect_to(new_user_session_path)
    end

    it "redirects to login for create" do
      post :create, params: { resource_category: FactoryBot.attributes_for(:resource_category) }
      expect(response).to redirect_to(new_user_session_path)
    end

    it "redirects to login for edit" do
      get :edit, params: { id: resource_category.id }
      expect(response).to redirect_to(new_user_session_path)
    end

    it "redirects to login for update" do
      patch :update, params: { id: resource_category.id, resource_category: { name: 'Updated' } }
      expect(response).to redirect_to(new_user_session_path)
    end

    it "redirects to login for activate" do
      patch :activate, params: { id: resource_category.id }
      expect(response).to redirect_to(new_user_session_path)
    end

    it "redirects to login for deactivate" do
      patch :deactivate, params: { id: resource_category.id }
      expect(response).to redirect_to(new_user_session_path)
    end

    it "redirects to login for destroy" do
      delete :destroy, params: { id: resource_category.id }
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "as a logged in user" do
    let(:user) { FactoryBot.create(:user, :organization_approved) }
    before { sign_in user }

    it "redirects to root for index" do
      get :index
      expect(response).to redirect_to(dashboard_path)
    end

    it "redirects to root for new" do
      get :new
      expect(response).to redirect_to(dashboard_path)
    end

    it "redirects to root for create" do
      post :create, params: { resource_category: FactoryBot.attributes_for(:resource_category) }
      expect(response).to redirect_to(dashboard_path)
    end

    it "redirects to root for edit" do
      get :edit, params: { id: resource_category.id }
      expect(response).to redirect_to(dashboard_path)
    end

    it "redirects to root for update" do
      patch :update, params: { id: resource_category.id, resource_category: { name: 'Updated' } }
      expect(response).to redirect_to(dashboard_path)
    end

    it "redirects to root for activate" do
      patch :activate, params: { id: resource_category.id }
      expect(response).to redirect_to(dashboard_path)
    end

    it "redirects to root for deactivate" do
      patch :deactivate, params: { id: resource_category.id }
      expect(response).to redirect_to(dashboard_path)
    end

    it "redirects to root for destroy" do
      delete :destroy, params: { id: resource_category.id }
      expect(response).to redirect_to(dashboard_path)
    end
  end

  describe "as an admin" do
    let(:user) { FactoryBot.create(:user, :admin) }
    before { sign_in user }

    it "renders index successfully" do
      get :index
      expect(response).to be_successful
    end

    it "renders new successfully" do
      get :new
      expect(response).to be_successful
    end

    it "creates a resource category and redirects" do
      expect {
        post :create, params: { resource_category: FactoryBot.attributes_for(:resource_category) }
      }.to change(ResourceCategory, :count).by(1)
      expect(response).to redirect_to(resource_categories_path)
    end

    it "fails to save new resource category" do
      allow_any_instance_of(ResourceCategory).to receive(:save).and_return(false)
      post :create, params: { resource_category: FactoryBot.attributes_for(:resource_category) }
      expect(response).to be_successful
    end

    it "renders edit successfully" do
      get :edit, params: { id: resource_category.id }
      expect(response).to be_successful
    end

    it "updates resource category and redirects" do
      patch :update, params: { id: resource_category.id, resource_category: { name: 'Updated Name' } }
      expect(response).to redirect_to(resource_category)
      expect(resource_category.reload.name).to eq('Updated Name')
    end

    it "fails to update resource category" do 
      allow_any_instance_of(ResourceCategory).to receive(:update).and_return(false)
      patch :update, params: { id: resource_category.id, resource_category: { name: 'Updated Name' } }
      expect(response).to be_successful
    end

    it "activates the resource category and redirects" do
      allow_any_instance_of(ResourceCategory).to receive(:activate).and_return(true)
      patch :activate, params: { id: resource_category.id }
      expect(response).to redirect_to(resource_category)
      expect(flash[:notice]).to eq('Category activated.')
    end

    it "fails to activate and redirects with alert" do
      allow_any_instance_of(ResourceCategory).to receive(:activate).and_return(false)
      patch :activate, params: { id: resource_category.id }
      expect(response).to redirect_to(resource_category)
      expect(flash[:alert]).to eq('There was a problem activating the category.')
    end

    it "deactivates the resource category and redirects" do
      allow_any_instance_of(ResourceCategory).to receive(:deactivate).and_return(true)
      patch :deactivate, params: { id: resource_category.id }
      expect(response).to redirect_to(resource_category)
      expect(flash[:notice]).to eq('Category deactivated.')
    end

    it "fails to deactivate and redirects with alert" do
      allow_any_instance_of(ResourceCategory).to receive(:deactivate).and_return(false)
      patch :deactivate, params: { id: resource_category.id }
      expect(response).to redirect_to(resource_category)
      expect(flash[:alert]).to eq('There was a problem deactivating the category.')
    end

    it "destroys the resource category and redirects" do
      resource_category # ensure it's created before expect block
        delete :destroy, params: { id: resource_category.id }
      expect(response).to redirect_to(resource_categories_path)
      expect(flash[:notice]).to include("Category #{resource_category.name} was deleted.")
    end
  end

end
