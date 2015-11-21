class DashboardPresentor

  def task_lists
    List.unarchived
  end

  def archived_task_lists
    List.archived
  end
end
