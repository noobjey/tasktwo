class ListsController < ApplicationController
  before_action :require_user
  before_action :require_list_owner, only: [:edit, :update, :destroy]

  def new
    @list = List.new()
  end

  def create
    list = List.new(allowed_params)
    if list.save
      current_user.lists << list
      flash[:success] = "List #{list.title} created."
      redirect_to dashboard_path
    else
      flash[:error] = "List could not be created, try again."
      redirect_to new_list_path
    end

  end


  def edit
    @list = find_list()
  end


  def update
    updated_list = find_list().update_attributes(allowed_params)

    if updated_list
      flash[:success] = "List #{find_list().title} updated."
      redirect_to dashboard_path
    else
      flash[:error] = "List could not be updated, try again."
      redirect_to :back
    end

  end


  def destroy
    list_to_delete = find_list().destroy

    if list_to_delete
      flash[:success] = "List #{list_to_delete.title} removed."
    else
      flash[:error] = "You cannot remove an unarchived task."
    end

    redirect_to dashboard_path
  end


  private

  def find_list
    List.find_by(id: params[:id])
  end

  def allowed_params
    params.require(:list).permit(:title, :archive)
  end

  def require_list_owner
    redirect_to dashboard_path unless find_list().user_id == current_user.id
  end
end
