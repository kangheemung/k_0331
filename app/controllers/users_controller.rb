class UsersController < ApplicationController
  def index
      @users=User.all
 
  end

  def new
    @user=User.new
    p"==============="
    p params
    p"==================new"
   
  end
  def create
   @user=User.new(user_params)
    p"========create======"
    p params
    p"=================="
    p"============"
      p @user.errors.full_messages
      p"============"
    user=User.new(user_params)
    if user.save
      p"============"
      p @user.errors.full_messages
      p"============"
      session[:user_id] = user.id
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end
  def update
  end

  def edit
  end
  
  def user_params
    params.require(:user).permit(:username,:email,:password,:password_confirmation)
  end
end
