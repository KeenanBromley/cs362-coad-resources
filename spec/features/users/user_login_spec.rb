require 'rails_helper'

RSpec.describe 'Logging in', type: :feature do
  it 'User Login' do
    visit root_path
    click_link 'Log in'
    fill_in 'Email address', with: "bromleyk@oregonstate.edu"
    fill_in 'Password', with: "password"
    click_on 'Sign in'

    expect(current_path).to eq dashboard_path
  end

end
