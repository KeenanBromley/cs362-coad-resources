require 'rails_helper'

RSpec.describe 'Updating an Organization', type: :feature do
  before do
    @user = create(:user, :organization_approved)
  end
  it 'User updating an organization' do
    log_in_as(@user)
    expect(current_path).to eq (dashboard_path)
    #puts page.html
    click_on 'Edit Organization'
    fill_in 'Name', with: 'Updated Name'
    fill_in 'Phone', with: '971-971-9710'
    fill_in 'Description', with: "Updated Organization"
    click_on 'Update Resource'
    expect(current_path).to eq organization_path(id: @user.organization.id)
  end
end
