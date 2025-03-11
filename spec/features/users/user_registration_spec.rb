require 'rails_helper'

RSpec.describe 'User registration', type: :feature do
  it 'User registration' do
    visit root_path
    click_link 'Sign up'
    fill_in 'Email address', with: "exampleemail@example.com"
    fill_in 'Password', with: "password"
    fill_in 'Password confirmation', with: "password"

    click_on 'Sign up'
  end
end
