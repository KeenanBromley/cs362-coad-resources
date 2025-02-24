require 'rails_helper'

RSpec.describe 'Creating a Region', type: :feature do

  before do
    @admin = create(:user, :admin)
  end



  it 'Admin creates a region spec' do
    log_in_as(@admin)

    visit root_path

    click_on 'Regions'
    click_on 'Add Region'

    fill_in 'Name', with: "Collins house"
    click_on 'Add Region'

    expect(current_path).to eq regions_path

  end

end
