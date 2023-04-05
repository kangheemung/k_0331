class SessionsController < ApplicationController
  def new
  end
  def create
    user=User.find_by(email: params[:users][:email].downcase)
    if user&&user.authenticate(params[:users][:password])
      
      session[:user_id] = user.id
      flash[:notice]="ログインしました。"
      redirect_to users_show_path(user.id)
    else
      :new
    end
  end
  def destroy
  session[:user_id]=nil
  flash[:notice] ="logout"
  redirect_to root_path
  end
end
