require 'rails_helper'
require 'support/login_helper'

RSpec.feature "Logins:", type: :feature do

  include LoginHelper

  before do
    stub_omniauth_github()
  end

  describe "a user that visits the login page" do
    let(:login_button) { "Login with Github" }

    before do
      visit root_path
    end

    context "and is not logged in" do

      it "sees a login button" do
        expect(current_path).to eq root_path
        expect(page).to have_link login_button
      end

      it "can login" do
        click_on login_button

        expect(current_path).to eq dashboard_path
        expect(page).to have_content "Logout"
      end

      it "cannot see dashboard" do
        visit dashboard_path

        expect(current_path).to eq root_path
      end

    end


    context "and has already logged in" do
      before do
        visit root_path
        click_on login_button
      end

      it "sees their dashboard" do
        visit root_path

        expect(current_path).to eq(dashboard_path)
      end

      it "can logout" do
        click_on "Logout"

        expect(current_path).to eq(root_path)
      end
    end
  end
end
