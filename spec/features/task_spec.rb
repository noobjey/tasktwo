require "rails_helper"
require "support/login_helper"

RSpec.feature "Tasks:", type: :feature do

  include LoginHelper

  describe "a user" do
    let!(:user) { create(:user) }

    before do
      stub_omniauth_github
      login_user()
    end

    context "with a list" do
      let!(:list_with_no_tasks) { create(:list, tasks_count: 0, user: user) }

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

        expect(current_path).to eq(new_list_task_path(list_with_no_tasks))
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
            expect(page).to have_content "New task description."
            expect(page).to have_content "01 January 2016"
          end
        end
      end
    end

    context "with existing tasks" do
      let!(:list_with_a_task) { create(:list, tasks_count: 1, user: user) }
      let!(:task) { list_with_a_task.tasks.first }

      before do
        visit dashboard_path
      end

      it "can update a task" do
        edit_first_task()

        expect(current_path).to eq(edit_list_task_path(list_with_a_task, list_with_a_task.tasks.first))
        fill_in "Title", with: "Updated Task Title"
        fill_in "Description", with: "Updated task description."
        fill_in "Due date", with: "01/01/2019"
        click_on "Update Task"

        expect(current_path).to eq(dashboard_path)

        within "#task-lists" do
          within first("ul li .collapsible-body") do
            expect(page).to have_content "Updated Task Title"
            expect(page).to have_content "Updated task description."
            expect(page).to have_content "01 January 2019"
          end
        end
      end

      it "can complete a task" do
        edit_first_task()

        check "Status"
        click_on "Update Task"

        within "#task-lists" do
          within first("ul li .collapsible-body") do
            expect(page).not_to have_content task.title
            expect(page).not_to have_content task.description
          end
        end
      end
    end

    context "with completed tasks" do
      let!(:list_with_completed_tasks) { create(:list_with_completed_tasks, tasks_count: 1, user: user) }
      let!(:completed_task) { list_with_completed_tasks.tasks.last }
      before do
        visit dashboard_path
      end

      it "can see lists with those tasks" do
        click_on "Completed Tasks"

        within "#completed-task-lists" do
          within find("ul li .collapsible-body") do
            expect(page).to have_content completed_task.title
            expect(page).to have_content completed_task.description
            expect(page).to have_content completed_task.status_string
          end
        end
      end

      it "can change completed status" do
        list_with_completed_tasks.tasks.uncompleted.first.delete

        visit dashboard_path

        click_on "Completed Tasks"

        within "#completed-task-lists" do
          within find("ul li .collapsible-body") do
            click_on "Edit"
          end
        end

        expect(current_path).to eq(edit_list_task_path(list_with_completed_tasks, list_with_completed_tasks.tasks.first))
        uncheck "Status"
        click_on "Update Task"

        within "#task-lists" do
          within find("ul li .collapsible-body") do
            expect(page).to have_content completed_task.title
            expect(page).to have_content completed_task.description
          end
        end
      end
    end
  end


  private

  def edit_first_task
    within "#task-lists" do
      within first("ul li .collapsible-body") do
        click_on "Edit"
      end
    end
  end

end
