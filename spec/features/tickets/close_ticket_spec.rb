require 'rails_helper'

RSpec.describe 'Closing a ticket', type: :feature do

  before do
    @user = create(:user, :admin)  # Assuming an admin user
    @ticket = create(:ticket)  # Assuming a ticket exists
    log_in_as(@user)  # Log in as admin user
  end

  it 'admin closes a ticket and redirects to the correct dashboard section' do
    visit dashboard_path

    # Find the ticket and click the close button
    click_on @ticket.name
    click_on 'Close'

    # Reload ticket from the database to check its status
    @ticket.reload

    # Verify that the ticket is closed
    expect(@ticket.closed).to eq(true)

    # Verify redirection path for admin
    expect(current_path).to eq(dashboard_path)
    expect(current_url).to include('#tickets:open')
  end


end
