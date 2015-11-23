class TasksController < ApplicationController
  before_action :require_user

  def new
    @list = find_list()
    @task = Task.new
  end

  def create
    task = Task.new(allowed_params)

    if task.save
      find_list.tasks << task
      flash[:success] = "Task #{task.title} created."
      redirect_to dashboard_path
    else
      flash[:error] = "Problem creating task, try again."
      redirect_to new_list_task_path(find_list)
    end

  end

  def edit
    @list = find_list
    @task = find_task()
  end

  def update
    if task_updated
      find_list.tasks << find_task
      flash[:success] = "Task #{find_task.title} updated."
      redirect_to dashboard_path
    else
      flash[:error] = "Problem updating task, try again."
      redirect_to :back
    end
  end


  private

  def allowed_params
    params.require(:task).permit(:status, :title, :description, :due_date)
  end

  def find_task
    Task.find_by(id: params[:id])
  end

  def find_list
    List.find_by(id: params[:list_id])
  end

  def task_updated
    find_task.update_attributes(allowed_params)
  end
end
