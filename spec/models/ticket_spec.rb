require 'rails_helper'

RSpec.describe Ticket, type: :model do

  let (:ticket) {FactoryBot.build_stubbed(:ticket)}
  
  it "exists" do
    Ticket.new
  end

  describe "association" do
    it { should belong_to(:region) }
    it { should belong_to(:resource_category) }
    it { should belong_to(:organization).optional }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:phone) }
    it { should validate_presence_of(:region_id) }
    it { should validate_presence_of(:resource_category_id) }
    it { should validate_length_of(:name).is_at_least(1).is_at_most(255).on(:create) }
    it { should validate_length_of(:description).is_at_most(1020).on(:create) }
    it "is valid with a plausible phone number" do
      ticket = create(:ticket, phone: "+14155552671") # Example valid phone number
      expect(ticket).to be_valid
    end
  
    it "is invalid with an implausible phone number" do
      ticket = build(:ticket, phone: "12345") # Clearly invalid phone number
      expect(ticket).to be_invalid
      expect(ticket.errors[:phone]).to include("is an invalid number") # Adjust the error message if needed
    end
  end

  describe "instance methods" do
    it "#open?" do
      expect(ticket.open?).to eq(!ticket.closed)
    end

    it "#captured?" do
      expect(ticket.captured?).to eq(ticket.organization.present?)
    end

    it "#to_s" do
      expect(ticket.to_s).to eq("Ticket #{ticket.id}")
    end
  end

  describe "scope" do 
    let!(:open_record) { create(:ticket, closed: false, organization_id: nil) }
    let!(:closed_record) { create(:ticket, closed: true) }
    let!(:org_record) { create(:ticket, closed: false, organization_id: 1) }
    let!(:region_record) { create(:ticket, region_id: 1) }
    let!(:category_record) { create(:ticket, resource_category_id: 1) }

    context "open" do
      it "returns records that are open and have no organization" do
        expect(Ticket.open).to include(open_record)
        expect(Ticket.open).not_to include(closed_record, org_record)
      end
    end

    context "closed" do
      it "returns records that are closed" do
        expect(Ticket.closed).to include(closed_record)
        #expect(Ticket.closed).not_to include(open_record, org_record)
      end
    end

    context "all_organization" do
      it "returns records that are open and have an organization" do
        expect(Ticket.all_organization).to include(org_record)
        expect(Ticket.all_organization).not_to include(open_record, closed_record)
      end
    end

    context "organization" do
      it "returns records that belong to a specific organization" do
        expect(Ticket.organization(1)).to include(org_record)
        expect(Ticket.organization(1)).not_to include(open_record, closed_record)
      end
    end

    context "closed_organization" do
      it "returns records that are closed and belong to a specific organization" do
        closed_org_record = create(:ticket, closed: true, organization_id: 1)
        expect(Ticket.closed_organization(1)).to include(closed_org_record)
        expect(Ticket.closed_organization(1)).not_to include(closed_record, open_record)
      end
    end

    context "region" do
      it "returns records that belong to a specific region" do
        expect(Ticket.region(1)).to include(region_record)
        expect(Ticket.region(1)).not_to include(category_record)
      end
    end

    context "resource_category" do
      it "returns records that belong to a specific resource category" do
        expect(Ticket.resource_category(1)).to include(category_record)
        expect(Ticket.resource_category(1)).not_to include(region_record)
      end
    end
  end
end

