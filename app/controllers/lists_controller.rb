class ListsController < ApplicationController

  def new
    @list = List.new()
  end

  def create
    List.create(allowed_params)

    redirect_to dashboard_path
  end

  def edit
    @list = List.find_by(id: params[:id])
  end

  def update
    list = List.find_by(id: params[:id])
    list.update_attributes(allowed_params)

    redirect_to dashboard_path
  end

  private

  def allowed_params
    params.require(:list).permit(:title)
  end
end
