require 'rails_helper'

RSpec.describe 'Deleting a Ticket', type: :feature do
  before do
    @admin = create(:user, :admin)
  end



  it 'Admin deletes a ticket' do
    ticket = FactoryBot.create(:ticket)
    log_in_as(@admin)

    visit dashboard_path

    click_on ticket.name
    click_on 'Delete'

    expect(current_path).to eq dashboard_path
    expect(page.body).to have_no_text(ticket.name)
  end

end
