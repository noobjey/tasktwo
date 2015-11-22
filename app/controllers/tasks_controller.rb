class TasksController < ApplicationController
  def new
    @list = List.find_by(params[:id])
    @task = Task.new
  end

  def create
    list = find_list
    task = Task.create(allowed_params)

    if list && task
      list.tasks << task
      flash[:success] = "Task #{task.title} created."
    end

    redirect_to dashboard_path
  end

  def edit
    @list = find_list
    @task = find_task()
  end

  def update
    task = find_task()
    task.update_attributes(allowed_params)

    redirect_to dashboard_path
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
end
