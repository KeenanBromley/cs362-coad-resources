require 'rails_helper'

RSpec.describe User, type: :model do

  let (:user) {User.new}
  
  it "exists" do
    User.new
  end

  it "responds to email" do
    expect(user).to respond_to(:email)
  end

  it "responds to role" do
    expect(user).to respond_to(:role)
  end

  it "belongs to organization" do
    belong_to(:organization)
  end

  describe "validation tests" do
    it "validates presence of email" do
      should validate_presence_of(:email)
    end 

    it "validates length of email" do
      should validate_length_of(:email).is_at_least(1).is_at_most(255).on(:create)
    end 

    it "validates uniqueness of email" do
      should validate_uniqueness_of(:email).case_insensitive
    end
    
    it "validates presence of password" do
      should validate_presence_of(:password).on(:create)
    end

    it "validates length of password" do
      should validate_length_of(:password).is_at_least(7).is_at_most(255).on(:create)
    end 
  end 

end
