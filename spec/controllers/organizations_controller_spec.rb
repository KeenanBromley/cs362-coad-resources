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

require 'rails_helper'

RSpec.describe OrganizationsController, type: :controller do
  let(:organization) { FactoryBot.create(:organization) }

  describe 'as a logged out user' do 
    it 'redirects to login for index' do
      get :index
      expect(response).to redirect_to(new_user_session_path)
    end

    it 'redirects to login for new' do
      get :new
      expect(response).to redirect_to(new_user_session_path)
    end

    it 'redirects to login for create' do
      post :create, params: { organization: FactoryBot.attributes_for(:organization) }
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe 'as a logged in user' do
    let(:user) { FactoryBot.create(:user) }
    before { sign_in user }

    it 'renders new successfully if user has no organization' do
      get :new
      expect(response).to be_successful
    end

    it 'creates an organization and redirects on success' do
      allow(UserMailer).to receive_message_chain(:with, :new_organization_application, :deliver_now)

      expect {
        post :create, params: { organization: FactoryBot.attributes_for(:organization) }
      }.to change(Organization, :count).by(1)

      expect(response).to redirect_to(organization_application_submitted_path)
    end

    it 'renders new when create fails' do
      allow_any_instance_of(Organization).to receive(:save).and_return(false)
      post :create, params: { organization: { name: '' } }
      expect(response).to be_successful

    end
  end

  describe 'as an approved organization user' do
    let(:user) { FactoryBot.create(:user, :organization_approved) }
    before { sign_in user }

    it 'updates organization and redirects on success' do
      organization = FactoryBot.create(:organization)
      organization.approve
      patch :update, params: { id: organization.id, organization: { name: 'Updated Name' } }
      expect(response).to redirect_to(organization_path(organization))
    end

    it 'fails to save and renders edit' do 
      allow_any_instance_of(Organization).to receive(:save).and_return(false)
      organization = FactoryBot.create(:organization)
      organization.approve
      patch :update, params: { id: organization.id, organization: { name: 'Updated Name' } }
      expect(response).to be_successful
    end
  end

  describe 'as an admin' do
    let(:user) { FactoryBot.create(:user, :admin) }
    before { sign_in user }

    it 'renders index successfully' do
      get :index
      expect(response).to be_successful
    end

    it 'renders show successfully' do
      get :show, params: { id: organization.id }
      expect(response).to be_successful
    end

    # it 'responds with successful status and includes form when update fails' do
    #   organization.update(status: :approved)
    #   allow_any_instance_of(Organization).to receive(:update).and_return(false)
    #   patch :update, params: { id: organization.id, organization: { name: '' } }
    #   expect(response).to be_successful
    #   expect(response.body).to include('Edit Organization')
    # end

    it 'approves organization and redirects with notice' do
      post :approve, params: { id: organization.id }
      expect(response).to redirect_to(organizations_path)
      expect(flash[:notice]).to eq("Organization #{organization.name} has been approved.")
    end

    #it 'fails to approve and renders organization path' do
    #  allow_any_instance_of(Organization).to receive(:save).and_return(false)
    #  organization = FactoryBot.create(:organization)
    #  post :approve, params: { id: organization.id }
    #  expect(response).to be_successful
    #end
      

    it 'rejects organization and redirects with notice' do
      post :reject, params: { id: organization.id, organization: { rejection_reason: 'Insufficient info' } }
      expect(response).to redirect_to(organizations_path)
      expect(flash[:notice]).to eq("Organization #{organization.name} has been rejected.")
      expect(organization.reload.rejection_reason).to eq('Insufficient info')
    end
  end

end
