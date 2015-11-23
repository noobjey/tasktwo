class DashboardController < ApplicationController
  before_action :require_user

  def index
    @dashboard_presentor = DashboardPresentor.new(current_user)
  end

end
