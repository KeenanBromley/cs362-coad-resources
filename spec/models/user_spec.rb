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

    valid_email = "bobthebuilder@gmail.com"
    let (:user1) {FactoryBot.build_stubbed(:user, email: valid_email)}
    invalid_email = "bobthebuilder"
    let (:user2) {FactoryBot.build_stubbed(:user, email: invalid_email)}
    it "validates email format" do 
      valid_email = "bobthebuilder@gmail.com"
      invalid_email = "bobthebuilder"
      expect(User.new(email: valid_email, password: "password")).to be_valid
      expect(User.new(email: invalid_email, password: "password")).not_to be_valid
    end
  end 

  describe "member function tests" do
    it "responds to to_s" do
      expect(user.to_s).to eq(user.email)
    end 

    it "responds to set_default role" do
      expect(user.set_default_role).to eq(user.role)
    end
  end

end
