require "rails_helper"

RSpec.describe ListsController, type: :controller do

  describe "#delete" do

    let!(:list_archived) {List.create(title: "An Archived List", archive: true)}

    it "can delete an archived task" do
      delete :destroy, id: list_archived.id

      expect(flash[:success]).to eq("List #{list_archived.title} removed.")
    end
  end
end
