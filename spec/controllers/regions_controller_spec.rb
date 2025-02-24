require 'rails_helper'

# GET    /regions(.:format)           regions#index
# POST   /regions(.:format)           regions#create
# GET    /regions/new(.:format)       regions#new
# GET    /regions/:id/edit(.:format)  regions#edit
# GET    /regions/:id(.:format)       regions#show
# PATCH  /regions/:id(.:format)       regions#update
# PUT    /regions/:id(.:format)       regions#update
# DELETE /regions/:id(.:format)       regions#destroy

RSpec.describe RegionsController, type: :controller do

  describe 'as a logged out user' do
    let(:user) { FactoryBot.create(:user) }

    it { expect(get(:index)).to redirect_to new_user_session_path }
    it {
      post(:create, params: { region: FactoryBot.attributes_for(:region) })
      expect(response).to redirect_to new_user_session_path
    }
    it { expect(get(:new)).to redirect_to new_user_session_path }
    it { expect(get(:edit, params: { id: 1 })).to redirect_to new_user_session_path }
    it { expect(get(:show, params: { id: 1 })).to redirect_to new_user_session_path }
    it { expect(patch(:update, params: { id: 1 })).to redirect_to new_user_session_path }
    it { expect(put(:update, params: { id: 1 })).to redirect_to new_user_session_path }
    it { expect(delete(:destroy, params: { id: 1 })).to redirect_to new_user_session_path }
  end

  describe 'as a logged in user' do
    let(:user) { FactoryBot.create(:user) }
    let!(:region) { FactoryBot.create(:region) } 
    before(:each) { sign_in user }

    it { expect(get(:index)).to redirect_to dashboard_path }
    it {
      post(:create, params: { region: FactoryBot.attributes_for(:region) })
      expect(response).to redirect_to dashboard_path
    }
    it { expect(get(:new)).to redirect_to dashboard_path }
    it { expect(get(:edit, params: { id: region.id })).to redirect_to dashboard_path }
    it { expect(get(:show, params: { id: region.id })).to redirect_to dashboard_path }
    it { expect(patch(:update, params: { id: region.id })).to redirect_to dashboard_path }
    it { expect(put(:update, params: { id: region.id })).to redirect_to dashboard_path }
    it { expect(delete(:destroy, params: { id: region.id })).to redirect_to dashboard_path }

    context "when update fails due to invalid parameters" do
      let(:invalid_params) { { id: region.id, region: { name: "" } } }

      #it "renders the edit template" do
      #  patch :update, params: invalid_params
      #  expect(response).to redirect_to dashboard_path
      #end

    end
  end

  describe 'as an admin' do
    let(:user) { FactoryBot.create(:user, :admin) }
    let(:region) { FactoryBot.create(:region) }
    before(:each) { sign_in user }

    it { expect(get(:index)).to be_successful }
    it {
      post(:create, params: { region: FactoryBot.attributes_for(:region) })
      expect(response).to redirect_to regions_path
    }
    it { expect(get(:new)).to be_successful }
    it { expect(get(:edit, params: { id: region.id })).to be_successful }
    it { expect(get(:show, params: { id: region.id })).to be_successful}
    it {
      patch(:update, params: { id: region.id, region: { name: "Updated Region" }})
      expect(response).to redirect_to region_path(region)
    }
    it {
      put(:update, params: { id: region.id, region: { name: "Updated Region" }})
      expect(response).to redirect_to region_path(region)
    } 
    it {
      delete(:destroy, params: { id: region.id })
      expect(response).to redirect_to regions_path
      expect(Region.exists?(region.id)).to be_falsey
    }

    it { 
      region = build(:region)

      allow(Region).to receive(:new).and_return(region)
      allow(region).to receive(:save).and_return(false)

      post(:create, params: { region: FactoryBot.attributes_for(:region) })
      expect(response).to be_successful
    }
  end
end