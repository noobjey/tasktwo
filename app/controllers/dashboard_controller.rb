class DashboardController < ApplicationController

  def index
    @dashboard_presentor = DashboardPresentor.new
  end

end
