require "rails_helper"
require "support/login_helper"

RSpec.describe ListsController, type: :controller do

  describe "#delete", focus: true do
    let!(:user) { create(:user) }
    let!(:list_archived) { create(:archived_list) }
    let!(:list_unarchived) { create(:list) }

    before do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    end

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
