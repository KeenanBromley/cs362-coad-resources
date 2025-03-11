require 'rails_helper'

RSpec.describe 'Deleting a Resource Category', type: :feature do
  before do 
    @admin = create(:user, :admin)
  end
  it 'Admin deletes a region spec' do
    log_in_as(@admin)

    res_cat = FactoryBot.create(:resource_category)

    visit root_path

    click_on 'Categories'


    click_on res_cat.name
    click_on 'Delete'

    expect(current_path).to eq resource_categories_path

    expect(page.body).to have_no_text('Animal Rescue')

  end

end
