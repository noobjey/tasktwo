class DashboardPresentor
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def task_lists
    user.lists.unarchived
  end

  def archived_task_lists
    user.lists.archived
  end

  def task_lists_with_completed_tasks
    user.lists.unarchived.with_completed_tasks
  end
end
