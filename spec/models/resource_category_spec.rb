require 'rails_helper'

RSpec.describe ResourceCategory, type: :model do

  let (:res_cat) {ResourceCategory.new}
  
  it "exists" do
    ResourceCategory.new
  end

  describe "responds to" do
    it "responds to name" do
      expect(res_cat).to respond_to(:name)
    end 

    it "responds to active" do
      expect(res_cat).to respond_to(:active)
    end

    it "has many tickets" do
      should have_many(:tickets)
    end
    
    it "has and belongs to many organizations" do
      should have_and_belong_to_many(:organizations)
    end
  end

  describe "validation tests" do
    it "validates presence of name" do
      should validate_presence_of(:name)
    end

    it "validates length of name" do
      should validate_length_of(:name).is_at_least(1).is_at_most(255).on(:create)
    end

    it "validates uniqueness of name" do
      should validate_uniqueness_of(:name).case_insensitive
    end
  end

  describe "member function tests" do
    it "activates" do
      expect(res_cat.active).to eq(true)
    end

    it "deactivates" do
      expect(res_cat.deactivate).to eq(false)
    end

    it "is inactive?" do
      expect(res_cat.inactive?).to eq(!res_cat.active)
    end

    it "responds to to_s" do
      expect(res_cat.to_s).to eq(res_cat.name)
    end
  end

  describe "scope tests" do
    it "responds to active" do
      expect(ResourceCategory).to respond_to(:active)
    end

    it "responds to inactive" do
      expect(ResourceCategory).to respond_to(:inactive)
    end
  end
end
