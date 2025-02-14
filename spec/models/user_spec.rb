require 'rails_helper'

RSpec.describe User, type: :model do

  let (:user) {FactoryBot.build_stubbed(:user)}
  
  it "exists" do
    User.new
  end

  describe "association" do
    it { should belong_to(:organization).optional }
  end

  describe "validation" do
    it { validate_presence_of(:email) }
    it { validate_length_of(:email).is_at_least(1).is_at_most(225).on(:create) }
    it { validate_uniqueness_of(:email).case_insensitive }
    it { validate_presence_of(:password).on(:create) }
    it { validate_length_of(:password).is_at_least(7).is_at_most(255).on(:create) }
  end

  describe "instance methods" do
    it "#set_default_role" do
      expect(user.set_default_role).to eq(user.role)
    end

    it "#to_s" do
      expect(user.to_s).to eq(user.email)
    end 
  end
end
