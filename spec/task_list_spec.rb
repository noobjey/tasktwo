require "rails_helper"

RSpec.feature "Lists:", type: :feature do

  describe "a user" do

    it "can create a list" do
      visit dashboard_path

      within "#task-lists" do
        expect page.to have_button "New Task"
        click_on "New Task"
      end

      expect(current_path).to eq(new_task_path)
    end
  end
end
