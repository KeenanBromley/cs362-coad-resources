require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
    describe "#full title" do
      it "returns only the base title when page_title is empty" do
        expect(helper.full_title('')).to eq('Disaster Resource Network')
      end

      it "returns page title followed by base title when page_title is provided" do
        expect(helper.full_title('Home')).to eq('Home | Disaster Resource Network')
      end

      it "returns page title followed by base title when page_title has multiple words" do
        expect(helper.full_title('About Us')).to eq('About Us | Disaster Resource Network')
      end
    end

end
