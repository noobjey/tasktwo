class ListsController < ApplicationController

  def new
    @list = List.new()
  end

  def create
    List.create(allowed_params)

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
    list = find_list().destroy

    if list
      flash[:success] = "List #{list.title} removed."
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
