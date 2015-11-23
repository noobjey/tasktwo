class SessionsController < ApplicationController
  def new
    if current_user
      redirect_to dashboard_path
    end
  end

  def create
    if user = User.find_or_create_from_oauth(request.env['omniauth.auth'])
      session[:user_id] = user.id
    end
    redirect_to dashboard_path
  end

  def destroy
    session.delete :user_id
    redirect_to root_path
  end
end
