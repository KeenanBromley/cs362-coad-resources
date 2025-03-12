require 'rails_helper'

RSpec.describe 'Capturing a ticket', type: :feature do
  before do
    @user = create(:user, :organization_approved)
    
  end 

  it' captures the ticket' do
    ticket = FactoryBot.create(:ticket, name: 'Help Me')
    log_in_as(@user)
    visit dashboard_path
    click_on ticket.name
    pp ticket
    click_on 'Capture'
    ticket2 = Ticket.find(ticket.id)

    expect(current_path).to eq dashboard_path
    expect(ticket2.organization_id).to eq(@user.organization.id)
  end

end
