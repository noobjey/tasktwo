class ListsController < ApplicationController

  def new
    @list = List.new()
  end

  def create
    List.create(allowed_params)

    redirect_to dashboard_path
  end

  private

  def allowed_params
    params.require(:list).permit(:title)
  end
end
