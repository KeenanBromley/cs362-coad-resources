require 'rails_helper'

RSpec.describe 'Releasing a ticket by an', type: :feature do
  before do
    @admin_user = create(:user, :admin) 
    @ticket = create(:ticket) 
    
  end

  it 'admin can release a ticket and redirects to the correct dashboard section' do
    log_in_as(@admin_user)  
    visit dashboard_path

    click_on @ticket.name
    click_on 'Delete'

    expect(current_path).to eq(dashboard_path)
    expect(current_url).to have_no_text(@ticket.name)  
  end
end
