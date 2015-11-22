class TasksController < ApplicationController
  def new
    @list = List.find_by(params[:id])
    @task = Task.new
  end

  def create
    list = List.find_by(id: params[:list_id])
    task = Task.create(allowed_params)

    if list && task
      list.tasks << task
      flash[:success] = "Task #{task.title} created."
    end

    redirect_to dashboard_path
  end

  private

  def allowed_params
    params.require(:task).permit(:status, :title, :description, :due_date)
  end
end
