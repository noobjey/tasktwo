class ListsController < ApplicationController

  def new
    @list = List.new()
  end

  def create
    current_user.lists << List.create(allowed_params)

    redirect_to dashboard_path
  end

  def edit
    @list = find_list()
  end

  def update
    find_list().update_attributes(allowed_params)

    redirect_to dashboard_path
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
end
