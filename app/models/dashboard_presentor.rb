class DashboardPresentor

  def task_lists
    List.unarchived
  end

  def archived_task_lists
    List.archived
  end

  def task_lists_with_completed_tasks
    List.unarchived.with_completed_tasks
  end
end
