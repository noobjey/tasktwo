require "rails_helper"

RSpec.feature "Tasks:", type: :feature do

  let!(:list1) { create(:list, tasks_count: 0) }

  describe "a user" do
    before do
      visit dashboard_path
    end

    it "can create a task" do
      within "#task-lists" do
        within first("ul li .collapsible-body") do
          expect(page).to have_link "New Task"
          click_on "New Task"
        end
      end

      expect(current_path).to eq(new_list_task_path(list1))
      fill_in "Title", with: "New Task Title"
      fill_in "Description", with: "New task description."
      fill_in "Due date", with: "01/01/2016"
      click_on "Create Task"

      expect(current_path).to eq(dashboard_path)
      within "#flash-messages" do
        expect(page).to have_content("Task New Task Title created.")
      end

      within "#task-lists" do
        within first("ul li .collapsible-body") do
          expect(page).to have_content "New Task Title"
          expect(page).to have_content  "New task description."
          expect(page).to have_content  "01 Jan 2016"
        end
      end
    end

  end
end
