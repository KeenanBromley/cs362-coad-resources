require 'rails_helper'

RSpec.describe Ticket, type: :model do

  let (:ticket) {Ticket.new}
  
  it "exists" do
    Ticket.new
  end
  describe "responds to" do
    it "responds to name" do 
      expect(ticket).to respond_to(:name)
    end 

    it "responds to description" do
      expect(ticket).to respond_to(:description)
    end 

    it "responds to phone" do
      expect(ticket).to respond_to(:phone)
    end 

    it "responds to organization_id" do
      expect(ticket).to respond_to(:organization_id)
    end 

    it "responds to closed" do
      expect(ticket).to respond_to(:closed)
    end 

    it "responds to closed_at" do
      expect(ticket).to respond_to(:closed_at)
    end 

    it "responds to resource_category_id" do
      expect(ticket).to respond_to(:resource_category_id)
    end 

    it "responds to region_id" do
      expect(ticket).to respond_to(:region_id)
    end 
  end

  it "belongs to organization" do 
    belong_to(:organization)
  end

  it "belongs to region" do
    belong_to(:region)
  end
  
  it "belongs to resource_category" do
    belong_to(:resource_category)
  end
  describe "validation tests" do
    it "validates presence of name" do
      should validate_presence_of(:name)
    end

    it "validates presence of phone" do
      should validate_presence_of(:phone)
    end

    it "validates presence of region_id" do
      should validate_presence_of(:region_id)
    end

    it "validates presence of resource_category_id" do
      should validate_presence_of(:resource_category_id)
    end

    it "validates length of name" do
      should validate_length_of(:name).is_at_least(1).is_at_most(255).on(:create)
    end

    it "validates length of description" do
      should validate_length_of(:description).is_at_most(1020).on(:create)
    end

    it "validates phone" do
      should validate(:phone).phony_plausible
    end
  end
end
