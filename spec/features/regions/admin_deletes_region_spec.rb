require 'rails_helper'

RSpec.describe 'Deleting a Region', type: :feature do

  before do 
    @admin = create(:user, :admin)
  end
  it 'Admin deletes a region spec' do
    log_in_as(@admin)

    visit root_path

    click_on 'Regions'
    click_on 'Add Region'

    fill_in 'Name', with: "Collins House"
    click_on 'Add Region'

    expect(current_path).to eq regions_path

    click_on 'Collins House'
    click_on 'Delete'

    expect(current_path).to eq regions_path

    click_on 'Unspecified'
    click_on 'Delete'
    
    expect(current_path).to eq regions_path

    expect(page.body).to have_no_text('Collins House')

  end

end