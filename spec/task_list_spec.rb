require "rails_helper"

RSpec.feature "Lists:", type: :feature do

  describe "a user" do
    let!(:list_2) { List.create(title: "List Two") }
    let!(:list_3) { List.create(title: "List Three") }

    before do
      visit dashboard_path
    end

    it "can view all lists" do
      within "#task-lists" do
        expect(page).to have_content(list_2.title)
        expect(page).to have_content(list_3.title)
      end
    end

    it "can create a list" do
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

    it "can edit a list title" do
      within "#task-lists" do
        within first("tbody tr") do
          expect(page).to have_content(list_2.title)
          expect(page).to have_link "Edit"
          click_on "Edit"
        end
      end

      expect(current_path).to eq(edit_list_path(list_2))
      expect(page).to have_field("Title"), with: list_2.title
      fill_in "Title", with: "Modified Title"
      click_on "Update List"

      within "#task-lists" do
        expect(page).to have_content("Modified Title")
      end
    end
  end
end
