class SessionsController < ApplicationController
  def new
  end
  def create
    user=User.find_by(email: params[:users][:email].downcase)
    if user&&user.authenticate(params[:users][:password])
      session[:user_id] = user.id
      flash[:notice]="ログインしました。"
      redirect_to root_path
    else
      :new
    end
  end
end
