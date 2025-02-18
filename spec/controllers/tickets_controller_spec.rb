#POST   /tickets(.:format)                         tickets#create
#GET    /tickets/new(.:format)                     tickets#new
#GET    /tickets/:id(.:format)                     tickets#show
#GET    /ticket_submitted(.:format)                static_pages#ticket_submitted
#GET    /organization_expectations(.:format)       static_pages#organization_expectations
#POST   /tickets/:id/capture(.:format)             tickets#capture
#POST   /tickets/:id/release(.:format)             tickets#release
#PATCH  /tickets/:id/close(.:format)               tickets#close


require 'rails_helper'

RSpec.describe TicketsController, type: :controller do

  describe 'as a logged out user' do
    let(:user) { FactoryBot.create(:user) }

    it { r = FactoryBot.create(:region)
      rc = FactoryBot.create(:resource_category)
      o = FactoryBot.create(:organization)
      expect(post(:create, params: { ticket: FactoryBot.attributes_for(:ticket, region_id: r.id, organization_id: o.id, resource_category_id: rc.id)})).to redirect_to(ticket_submitted_path)
    }

    it { expect(get(:new)).to be_successful }

    it { t = FactoryBot.create(:ticket)
      expect(get(:show, params: { id: t.id })).to redirect_to dashboard_path
    }

    it { t = FactoryBot.create(:ticket)
      expect(post(:capture, params: { id: t.id })).to redirect_to dashboard_path
    }

    it { t = FactoryBot.create(:ticket)
      expect(post(:release, params: { id: t.id })).to redirect_to dashboard_path
    }

    it { t = FactoryBot.create(:ticket)
      expect(patch(:close, params: { id: t.id })).to redirect_to dashboard_path
    }
  end

  describe 'as a logged in user' do
    let(:user) { FactoryBot.create(:user, :organization_approved) }
    before(:each) { sign_in user }

    it { r = FactoryBot.create(:region)
      rc = FactoryBot.create(:resource_category)
      o = FactoryBot.create(:organization)
      expect(post(:create, params: { ticket: FactoryBot.attributes_for(:ticket, region_id: r.id, organization_id: o.id, resource_category_id: rc.id)})).to redirect_to(ticket_submitted_path)
    }

    it {expect(get(:new)).to be_successful }

    it { t = FactoryBot.create(:ticket)
      expect(get(:show, params: { id: t.id })).to be_successful
    }

    it { t = FactoryBot.create(:ticket)
      expect(post(:capture, params: { id: t.id })).to redirect_to dashboard_path << '#tickets:open'
    }

    it { t = FactoryBot.create(:ticket, organization: user.organization)
      expect(post(:release, params: { id: t.id })).to redirect_to dashboard_path << '#tickets:organization'
    }

    it { t = FactoryBot.create(:ticket, organization: user.organization)
      expect(patch(:close, params: { id: t.id })).to redirect_to dashboard_path << '#tickets:organization'
    }
  end

  describe 'as an admin' do
    let(:user) { FactoryBot.create(:user, :admin) }
    before(:each) { sign_in user }

    it { r = FactoryBot.create(:region)
      rc = FactoryBot.create(:resource_category)
      o = FactoryBot.create(:organization)
      expect(post(:create, params: { ticket: FactoryBot.attributes_for(:ticket, region_id: r.id, organization_id: o.id, resource_category_id: rc.id)})).to redirect_to(ticket_submitted_path)
    }

    it {expect(get(:new)).to be_successful }

    it { t = FactoryBot.create(:ticket)
      expect(get(:show, params: { id: t.id })).to be_successful
    }

    it { t = FactoryBot.create(:ticket)
      expect(post(:capture, params: { id: t.id })).to redirect_to dashboard_path
    }

    it { t = FactoryBot.create(:ticket)
      expect(post(:release, params: { id: t.id })).to redirect_to dashboard_path << '#tickets:captured'
    }

    it { t = FactoryBot.create(:ticket)
      expect(patch(:close, params: { id: t.id })).to redirect_to dashboard_path << '#tickets:open'
    }
  end

end
