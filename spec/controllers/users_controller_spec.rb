# spec/controllers/users_controller_spec.rb
require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:admin) { create(:user, :admin) }
  let(:user) { create(:user) }
  
  describe "GET #index" do
    context "when admin is logged in" do
      before { sign_in admin }

      it "returns a successful response" do
        get :index
        expect(response).to have_http_status(:success)
      end
    end

    context "when a regular user is logged in" do
      before { sign_in user }

      it "redirects to the dashboard" do
        get :index
        expect(response).to redirect_to(dashboard_path)
      end
    end

    context "when no user is logged in" do
      it "redirects to the login page" do
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end