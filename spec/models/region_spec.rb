require 'rails_helper'

RSpec.describe Region, type: :model do

  let (:region) {Region.new}
  it "exists" do
    Region.new
  end

  it "has a name" do
    expect(region).to respond_to(:name)
  end

  it "has a string representation that is its name" do
    name = 'Mt. Hood'
    region = Region.new(name: name)
    result = region.to_s
  end
  it "has many tickets" do
    should have_many(:tickets)
  end

  describe "validation tests" do
    it "validates presence of name" do
      should validate_presence_of(:name)
    end

    it "validates length of name" do
      should validate_length_of(:name)
    end

    it "validates uniqueness of name" do
      should validate_uniqueness_of(:name).case_insensitive
    end 
  end

  

end
