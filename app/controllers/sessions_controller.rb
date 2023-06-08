class SessionsController < ApplicationController
  def new
  end
  def create
    @user = User.find_by(email: params[:email].downcase)
    if @user && @user.authenticate(params[:password])
       p"============"
    p params 
    p"============"
      if @user.activated?
        log_in @user
        params[:remember_me] == '1' ? remember(@user) : forget(@user)
        redirect_back_or @user
      else
        
        flash[:warning] = "Check your email for the activation link."
        redirect_to root_url
      end
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
