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
      expect(page).to have_field("Title")
      expect(page).to have_button("Create")

      fill_in "Title", with: "First List"
      click_on "Create List"

      expect(current_path).to eq(dashboard_path)
      within "#task-lists" do
        expect(page).to have_content("First List")
      end
    end
  end
end
