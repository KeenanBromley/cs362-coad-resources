require 'rails_helper'

RSpec.describe DashboardController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:admin) { FactoryBot.create(:user, :admin) }
  let(:organization) { FactoryBot.create(:organization, :approved) }
  let(:org_user) { FactoryBot.create(:user, organization: organization) }
  
  describe 'as a logged out user' do
    it 'redirects to login page' do
      get :index
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe 'as a logged in user' do
    before do
      sign_in user
    end

    it 'shows the correct status options' do
      get :index
    end

    it 'shows tickets based on status' do
      allow(Ticket).to receive(:open).and_return(Ticket.none)
      get :index, params: { status: "Open" }
    end
  end

  describe 'as an approved organization user' do
    before do
      sign_in org_user
    end

    it 'shows the correct status options' do
      get :index
    end

    it 'shows tickets based on status' do
      allow(Ticket).to receive(:organization).and_return(Ticket.none)
      get :index, params: { status: "My Captured" }
    end
    it 'shows closed tickets for the organization' do
      allow(Ticket).to receive(:closed_organization).and_return(Ticket.none)
      get :index, params: { status: "My Closed" }
    end
  end

  describe 'as an admin' do
    before do
      sign_in admin
    end

    it 'shows the correct status options' do
      get :index
    end

    it 'shows tickets based on status' do
      allow(Ticket).to receive(:open).and_return(Ticket.none)
      get :index, params: { status: "Open" }  
    end

    it 'shows closed tickets' do
      allow(Ticket).to receive(:closed).and_return(Ticket.none)
      get :index, params: { status: "Closed" }
    end

    it 'shows captured tickets' do
      allow(Ticket).to receive(:all_organization).and_return(Ticket.none)
      get :index, params: { status: "Captured" }
    end

    context 'with additional filters' do
      it 'filters tickets by region' do
        allow(Ticket).to receive(:all).and_return(Ticket.none)
        get :index, params: { region_id: 1 }
      end

      it 'filters tickets by resource category' do
        allow(Ticket).to receive(:all).and_return(Ticket.none)
        get :index, params: { resource_category_id: 1 }
      end

      it 'sorts tickets by newest first' do
        allow(Ticket).to receive(:all).and_return(Ticket.none)
        get :index, params: { sort_order: 'Newest First' }
      end
    end
  end
end
