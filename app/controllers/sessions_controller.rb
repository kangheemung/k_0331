class SessionsController < ApplicationController
  def new
  end
  def create
      render template: 'users/form', layout: 'user'
    p"============"
    p params 
    p"============"
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to user
     p"============"
    p params 
    p"============"
      params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
      redirect_to users_show_path(@user.id)
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
