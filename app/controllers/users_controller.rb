class UsersController < ApplicationController
    before_action :logged_in_user, only: [:edit, :update]
    before_action :correct_user,   only: [:edit, :update]

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
        log_in @user
        #p"========create======="
        #p params
        #p"=================="
        #p"============"
        #p @user.errors.full_messages
        #p"============"
      redirect_to users_show_path(@user.id)
      else
        render 'new'
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
      if @user.update_attributes(user_params)
          #  session[:user_id]=user.id
          flash[:success] = "Profile updated"
          redirect_to users_show_path(@user.id),data: {"turbolinks" => false}
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
      # beforeアクション

    # ログイン済みユーザーかどうか確認
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
    
        # 正しいユーザーかどうか確認
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless @user == current_user
    end
end
