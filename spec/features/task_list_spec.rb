require "rails_helper"
require "support/login_helper"

RSpec.feature "Lists:", type: :feature do
  include LoginHelper

  describe "a user" do
    let!(:user) { create(:user) }
    let!(:list_2) { create(:list, user: user) }
    let!(:list_3) { create(:list, user: user) }
    let!(:list_archived) { create(:archived_list, user: user) }
    let!(:list_with_completed_tasks) { create(:list_with_completed_tasks) }

    before do
      stub_omniauth_github()
      login_user()
    end

    context "viewing their lists" do

      it "sees unarchived lists by default" do
        within "#task-lists" do
          expect(page).to have_content(list_2.title)
          expect(page).to have_content(list_3.title)
          expect(page).not_to have_content(list_archived.title)
        end
      end

      it "can see archived lists" do
        within "#archived-task-lists" do
          expect(page).not_to have_content(list_2.title)
          expect(page).not_to have_content(list_3.title)
          expect(page).to have_content(list_archived.title)
        end
      end

      it "can see all tasks on archived list" do
        list_with_completed_tasks.update_attributes({ archive: true })

        visit dashboard_path

        within "#archived-task-lists" do
          expect(page).to have_content(list_with_completed_tasks.title)
          expect(page).to have_content("active")
          expect(page).to have_content("complete")
        end
      end

      it "can see all tasks on completed tasks list" do
        list_with_completed_tasks.tasks.first.update_attributes({ status: true })

        visit dashboard_path

        within "#completed-task-lists" do
          expect(page).to have_content(list_with_completed_tasks.title)
          expect(page).to have_content("active")
          expect(page).to have_content("complete")
        end
      end
    end


    context "that creates a list" do
      before do
        user.lists.delete_all
      end

      it "can see the new list" do
        create_new_list()

        expect(current_path).to eq(new_list_path)
        expect(page).to have_field("Title")
        expect(page).to have_button("Create")

        fill_in_list_title("First List")

        expect(current_path).to eq(dashboard_path)
        within "#task-lists" do
          expect(page).to have_content("First List")
        end
      end
    end


    context "that edits a list" do
      it "can update the title" do
        edit_first_list()

        expect(current_path).to eq(edit_list_path(list_2))
        expect(page).to have_field("Title", with: list_2.title)
        fill_in "Title", with: "Modified Title"
        click_on "Update List"

        within "#task-lists" do
          expect(page).to have_content("Modified Title")
        end
      end

      it "can archive a list" do
        edit_first_list()

        expect(page).to have_unchecked_field("Archive")
        check "Archive"

        click_on "Update List"

        within "#task-lists" do
          expect(page).not_to have_content(list_2.title)
        end
      end
    end


    context "that deletes a list" do
      it "can delete an archived list" do
        within "#archived-task-lists" do
          within first("ul li .collapsible-header") do
            click_on "Delete"
          end
        end

        within "#flash-messages" do
          expect(page).to have_content("List #{list_archived.title} removed.")
        end
        within "#archived-task-lists" do
          expect(page).not_to have_content(list_archived.title)
        end
      end

    end
  end


  private

  def edit_first_list
    within "#task-lists" do
      within first("ul li .collapsible-header") do
        expect(page).to have_content(list_2.title)
        expect(page).to have_link "Edit"
        click_on "Edit"
      end
    end
  end

  def create_new_list
    within "#task-lists" do
      expect(page).to have_link "New List"
      click_on "New List"
    end
  end

  def fill_in_list_title(title)
    fill_in "Title", with: title
    click_on "Create List"
  end

end
