class UsersController < ApplicationController
    before_action :logged_in_user, only: [:index,:edit, :update,:destroy]
    before_action :correct_user,   only: [:edit, :update]
    before_action :admin_user,     only: :destroy
    before_action :set_user, only: [:show, :edit, :update, :destroy]
  
  def index
      @users = User.paginate(page: params[:page])
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
        @user.send_activation_email#確認メールを送信
        flash[:info] = "Please check your email to activate your account."
        redirect_to root_path
         flash[:email] = "Your message was successfully sent."
         #p"========create======="
         #p params
         #p"=================="
         #p"============"
         #p @user.errors.full_messages
         #p"============"
      else
        flash.now[:error] = 'Invalid email/password combination'
        render 'new'
      end
  end
  
  def show
    @user=User.find_by(id: params[:id])
    @posts = @user.posts.paginate(page: params[:page])
  end
  
  def update
     #p"============"
        #   p @user.errors.full_messages
      #p"============"
       @user = User.find(params[:id])

      if @user.update_attributes(user_params)
          #  session[:user_id]=user.id
          flash[:success] = "Profile updated"
          redirect_to @user
      else
        render :edit
      end
  end
  
  def edit
      @user=User.find_by(id: params[:id])
  end
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_index_path
  end
  
  
  private
  def set_user
      @user = User.find(params[:id])     
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
       redirect_to(root_url) unless current_user?(@user)
    end
     # 管理者かどうかを確認
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
     # 有効化用のメールを送信する
  
end
