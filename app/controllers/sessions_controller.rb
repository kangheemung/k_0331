class SessionsController < ApplicationController
  def new
  end
  def create
    user=User.find_by(email: params[:user][:email].downcase)
    if user&&user.authenticate(params[:user][:password])
     log_in(user)
      #session[:user_id] = user.id
      remember(user)
      flash[:notice]="ログインしました。"
      redirect_to users_show_path(user.id)
    else
      :new
    end
  end
  
  def destroy
    log_out if logged_in?
    flash[:notice] ="logout"
    redirect_to root_path
  end
end
