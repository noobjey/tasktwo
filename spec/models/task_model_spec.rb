require "rails_helper"

RSpec.describe Task, type: :model do

  describe "Task:" do

    context "status scopes" do
      let!(:completed_task) { Task.create(status: true) }
      let!(:uncompleted_task) { Task.create(status: false) }

      it "#uncompeleted" do
        tasks = Task.uncompleted

        expect(tasks.count).to eq(1)
        expect(tasks.first).to eq(uncompleted_task)
      end

      it "#compeleted" do
        tasks = Task.completed

        expect(tasks.count).to eq(1)
        expect(tasks.first).to eq(completed_task)
      end

      it "returns text value of status" do
        expect(completed_task.status_string).to eq("complete")
        expect(uncompleted_task.status_string).to eq("active")
      end
    end

  end
end
