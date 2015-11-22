require "rails_helper"


RSpec.feature "Lists:", type: :feature do

  describe "a user" do
    let!(:list_2) { List.create(title: "List Two") }
    let!(:list_3) { List.create(title: "List Three") }
    let!(:list_archived) { List.create(title: "An Archived List", archive: true) }

    before do
      visit dashboard_path
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
    end

    context "that creates a list" do
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
          within first("tbody tr") do
            click_on "Delete"
          end
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
      within first("tbody tr") do
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
