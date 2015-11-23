require "rails_helper"

RSpec.describe Task, type: :model do

  describe "Task:" do

    context "status scopes" do
      let!(:completed_task) { Task.create(title: "title", status: true, due_date: Date.today()) }
      let!(:uncompleted_task) { Task.create(title: "title", status: false, due_date: Date.today()) }

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

      context "validations" do
        it "requires title" do
          task = Task.new(title: "")

          expect(task.valid?).to eq(false)
        end

        it "requires date" do
          task = Task.new(title: "title")

          expect(task.valid?).to eq(false)
        end


        it "date cannot be random string" do
          task = Task.new(title: "title", due_date: "not a date")

          expect(task.valid?).to eq(false)
        end
      end
    end

  end
end
