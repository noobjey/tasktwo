class DashboardPresentor
  attr_reader :lists

  def initialize(lists)
    @lists = lists
  end

  def task_lists
    lists
  end
end
