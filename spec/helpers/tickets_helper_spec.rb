require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the TIcketsHelper. For example:
#
# describe TIcketsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe TicketsHelper, type: :helper do
  describe "#format_phone_number" do
    it "normalizes a standard US phone number" do
      expect(helper.format_phone_number("555-123-4567")).to eq("+15551234567")
    end

    it "normalizes a US phone number with parentheses and spaces" do
      expect(helper.format_phone_number("(555) 123-4567")).to eq("+15551234567")
    end

    it "normalizes a US phone number with country code" do
      expect(helper.format_phone_number("1-555-123-4567")).to eq("+15551234567")
    end

    it "returns nil for an empty phone number" do
      expect(helper.format_phone_number("")).to be_nil
    end

    it "returns nil for nil input" do
      expect(helper.format_phone_number(nil)).to be_nil
    end

    it "does not modify an already formatted international number" do
      expect(helper.format_phone_number("+15551234567")).to eq("+15551234567")
    end
  end
end
