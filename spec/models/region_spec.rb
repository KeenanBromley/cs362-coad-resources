require 'rails_helper'

RSpec.describe Region, type: :model do

  let (:region) { FactoryBot.build_stubbed(:region) }
  
  it "exists" do
    Region.new
  end

  describe "association" do
    it { should have_many(:tickets) }
  end

  describe "validation" do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_least(1).is_at_most(255).on(:create) }
    it { should validate_uniqueness_of(:name).case_insensitive }
  end

  describe "instance methods" do
    it "#self.unspecified" do
      region = Region.unspecified
      expect(region.name).to eq("Unspecified")
    end

    it "#to_s" do
      expect(region.to_s).to eq(region.name)
    end
  end

end
