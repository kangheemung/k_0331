class UsersController < ApplicationController
  def index
      @users=User.all
  end

  def new
    @user=User.new
    #p"==============="
    #p params
    #p"==================new"
  end
  
  def create
    @user=User.new(user_params)
      if @user.save
        flash[:success] = "Welcome to the Sample App!"
        session[:user_id] = @user.id
        p"========create======="
        p params
        p"=================="
        #p"============"
        #p @user.errors.full_messages
        #p"============"
      redirect_to users_show_path(@user.id)
      else
        render :new
      end
  end
  
  def show
    @user=User.find_by(id: params[:id])
  end
  
  def update
     #p"============"
        #   p @user.errors.full_messages
      #p"============"
       @user=User.find_by(id: params[:id])
      if @user.update(user_params)
          #  session[:user_id]=user.id
          flash[:notice]="プランナー情報を更新しました。"
          redirect_to users_show_path(@user.id) ,data: {"turbolinks" => false}
      else
        render :edit
      end
  end
  
  def edit
      @user=User.find_by(id: params[:id])
  end
  
  def user_params
    params.require(:user).permit(:username,:email,:password,:password_confirmation)
  end
end
