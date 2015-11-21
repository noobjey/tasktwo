class DashboardController < ApplicationController

  def index

    lists = List.all
    @dashboard_presentor = DashboardPresentor.new(lists)
  end

end
