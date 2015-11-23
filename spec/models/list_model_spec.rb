require "rails_helper"

RSpec.describe List, type: :model do

  describe "List:" do

    before do
      @unarchived = List.create(title: "list 1", archive: false)
      @archived   = List.create(title: "list 2", archive: true)
    end

    it "will not delete an unarchived list" do
      expect(@unarchived.destroy).to eq(false)
    end

    it "will delete an archived list" do
      expect(!!@archived.destroy).to eq(true)
    end

    it "has unique title" do
      invalid_list = List.create(title: @archived.title)
      expect(invalid_list.valid?).to eq(false)
    end

    it "requires title" do
      invalid_list = List.create(title: '')
      expect(invalid_list.valid?).to eq(false)
    end

    context "#with completed tasks" do
      it "returns lists containing completed tasks" do
        list_with_completed_tasks = create(:list_with_completed_tasks)

        lists = List.with_completed_tasks

        expect(lists.count).to eq(1)
        expect(lists.first).to eq(list_with_completed_tasks)
      end
    end

    context "achived scopes" do
      it "#archived" do
        expect(List.archived.count).to eq(1)
        expect(List.archived.first).to eq(@archived)
      end

      it "#unarchived" do
        expect(List.unarchived.count).to eq(1)
        expect(List.unarchived.first).to eq(@unarchived)
      end
    end
  end
end
