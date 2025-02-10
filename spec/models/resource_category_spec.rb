require 'rails_helper'

RSpec.describe ResourceCategory, type: :model do
  let(:res_cat) { FactoryBot.build_stubbed(:resource_category) }
  
  it "exists" do
    expect(build(:resource_category)).to be_valid
  end

  describe "associations" do
    it { should have_many(:tickets) }
    it { should have_and_belong_to_many(:organizations) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_least(1).is_at_most(255).on(:create) }
    it { should validate_uniqueness_of(:name).case_insensitive }
  end

  

  describe "instance methods" do
    it "#activate" do
      res_cat1 = create(:resource_category)
      res_cat1.activate
      expect(res_cat1.active).to eq(true)
    end

    it "#deactivate" do
      res_cat1 = create(:resource_category)
      res_cat1.deactivate
      expect(res_cat1.active).to eq(false)
    end

    it "#inactive?" do
      expect(res_cat.inactive?).to eq(!res_cat.active)
    end

    it "#to_s" do
      expect(res_cat.to_s).to eq(res_cat.name)
    end
  end

  describe "scopes" do
    it "returns only active resource categories" do
      res_cat1 = create(:resource_category, name: "res_cat1", active: true)
      res_cat2 = create(:resource_category, name: "res_cat2", active: false)

      expect(ResourceCategory.active).to include(res_cat1)
      expect(ResourceCategory.active).not_to include(res_cat2)
    end
  end
end
