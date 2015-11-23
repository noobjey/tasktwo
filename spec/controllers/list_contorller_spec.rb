require "rails_helper"
require "support/login_helper"

RSpec.describe ListsController, type: :controller do

  include LoginHelper

  describe "#delete" do

    before do
      stub_omniauth_github()
      login_user()
    end

    let!(:list_archived) {List.create(title: "An Archived List", archive: true)}
    let!(:list_unarchived) {List.create(title: "An Unarchived List", archive: false)}

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
