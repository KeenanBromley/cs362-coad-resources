require 'rails_helper'

RSpec.describe 'Approving an organization', type: :feature do
  before do
    @admin = create(:user, :admin)
    @organization = create(:organization)
  end

  it 'approves an organization' do
    log_in_as(@admin)
    visit root_path
    click_on 'Organizations'
    expect(current_path).to eq organizations_path

    click_on 'Pending'
    click_on 'Review'
    click_on 'Approve'
    expect(current_path).to eq organizations_path
  end
end
