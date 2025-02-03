require 'rails_helper'

RSpec.describe Region, type: :model do

  let (:region) { FactoryBot.build_stubbed(:region) }
  it "exists" do
    Region.new
  end

  it "has a name" do
    expect(region).to respond_to(:name)
  end

  it "has a string representation that is its name" do
    name = 'Mt. Hood'
    region = FactoryBot.build_stubbed(:region, name: 'Mt. Hood') 
    result = region.to_s
    expect(result).to eq('Mt. Hood')
  end
  it "has many tickets" do
    should have_many(:tickets)
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

  describe "member functions tests" do
    it "responds to to_s" do
      expect(region).to respond_to(:to_s)
    end
  end
  

end
