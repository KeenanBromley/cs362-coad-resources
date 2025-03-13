# spec/features/admin_sees_user_list_spec.rb
require 'rails_helper'

RSpec.feature "Admin views user list", type: :feature do
  let(:admin) { create(:user, :admin) }
  let!(:users) { create_list(:user, 3) }

  scenario "Admin sees a list of users' emails" do
    log_in_as(admin)  # Assuming Devise's Warden helper

    visit users_path

    users.each do |user|
      expect(page).to have_content(user.email)
    end
  end
end
