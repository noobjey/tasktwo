require "rails_helper"

RSpec.describe ListsController, type: :controller do

  describe "#delete" do

    let!(:list_archived) {List.create(title: "An Archived List", archive: true)}
    let!(:list_unarchived) {List.create(title: "An Archived List", archive: false)}

    it "can delete an archived task" do
      delete :destroy, id: list_archived.id

      expect(flash[:success]).to eq("List #{list_archived.title} removed.")
    end

    it "cannot delete an unarchived task" do
      delete :destroy, id: list_unarchived.id

      expect(flash[:error]).to eq("You cannot remove an unarchived task.")
    end
  end
end
