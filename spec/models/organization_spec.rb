require 'rails_helper'

RSpec.describe Organization, type: :model do

  let (:organization) {Organization.new}

  describe "association" do
    it { should have_many(:users) }
    it { should have_many(:tickets) }
    it { should have_and_belong_to_many(:resource_categories) }
  end

  describe "validation" do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:phone) }
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:primary_name) }
    it { should validate_presence_of(:secondary_name) }
    it { should validate_presence_of(:secondary_phone) }
    it { should validate_length_of(:email).is_at_least(1).is_at_most(255).on(:create) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_length_of(:name).is_at_least(1).is_at_most(255).on(:create) }
    it { should validate_uniqueness_of(:name).case_insensitive }
    it { should validate_length_of(:description).is_at_most(1020).on(:create) }
  end

  describe "instance methods" do
    it "#approve" do
      organization.approve
      expect(organization.status).to eq("approved")
    end

    it "#reject" do
      organization.reject
      expect(organization.status).to eq("rejected")
    end

    it "#set_default_status" do
      organization.set_default_status
      expect(organization.status).to eq("submitted")
    end

    it "#to_s" do
      expect(organization.to_s).to eq(organization.name)
    end
  end

end

