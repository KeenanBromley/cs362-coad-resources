require 'rails_helper'

RSpec.describe ResourceCategory, type: :model do

  let (:res_cat) {ResourceCategory.new}
  
  it "exists" do
    ResourceCategory.new
  end

  it "responds to name" do
    expect(res_cat).to respond_to(:name)
  end 

  it "responds to active" do
    expect(res_cat).to respond_to(:active)
  end



end
