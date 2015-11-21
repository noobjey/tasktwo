require "rails_helper"

RSpec.feature "Lists:", type: :feature do

  describe "a user" do

    it "can create a list" do
      visit dashboard_path

      within "#task-lists" do
        expect(page).to have_link "New List"
        click_on "New List"
      end

      expect(current_path).to eq(new_list_path)
    end
  end
end
