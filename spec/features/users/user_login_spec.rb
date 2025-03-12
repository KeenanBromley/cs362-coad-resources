require 'rails_helper'

RSpec.describe 'Logging in', type: :feature do
  it 'User Login' do
    user = FactoryBot.create(:user)
    visit root_path
    click_link 'Log in'
    fill_in 'Email address', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Sign in'

    expect(current_path).to eq dashboard_path
  end

end
