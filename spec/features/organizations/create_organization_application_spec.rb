require 'rails_helper'

RSpec.describe 'Creating an Organization Application', type: :feature do

  before do
    @user = create(:user)
    @admin = create(:user, :admin)
  end

  it 'redirects to organization application submitted path' do
    log_in_as(@user)
    puts current_path
    click_on 'Create Application'
    puts current_path
    choose "organization_liability_insurance_true"
    choose "organization_agreement_one_true"
    choose "organization_agreement_two_true"
    choose "organization_agreement_three_true"
    choose "organization_agreement_four_true"
    choose "organization_agreement_five_true"
    choose "organization_agreement_six_true"
    choose "organization_agreement_seven_true"
    choose "organization_agreement_eight_true"

    # Fill in text fields
    fill_in "organization_primary_name", with: "Doe, John"
    fill_in "organization_name", with: "Helping Hands"
    fill_in "organization_title", with: "Director"
    fill_in "organization_phone", with: "123-456-7890"
    fill_in "organization_secondary_name", with: "Jane Smith"
    fill_in "organization_secondary_phone", with: "098-765-4321"
    fill_in "organization_email", with: "contact@helpinghands.org"

    # Check all available checkboxes (adjust this if you want specific ones)
    page.all("input[type='checkbox']").each(&:check)

    # Fill in description
    fill_in "organization_description", with: "We are donating food, clothing, and hygiene products."

    # Select transportation option
    choose "organization_transportation_yes"

    # Submit the form
    click_button "Apply"

    expect(current_path).to eq(organization_application_submitted_path)
    expect(page.body).to have_text('Application Submitted')
  end

end
