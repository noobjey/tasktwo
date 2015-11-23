class DashboardController < ApplicationController

  def index
    @dashboard_presentor = DashboardPresentor.new(current_user)
  end

end
