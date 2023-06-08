class PostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy
  #def index
   # @posts=Post.all
  #end

  #def new
    #@post=Post.new
  #end

  #def show
    #user = User.find(params[:id])
    #@posts=user.posts.all
  
  #end
  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "Post created!"
      redirect_to root_path
    else
      @feed_items = [  ]
      render 'static_pages/home'
    end  
    #p "==========create"
    #p  params
 
    #p "==========create_saved"
      #p  params
     #p"============"
      #p @user.errors.full_messages
      #p"============"
    #p params
    #redirect_to posts_path(@post.id)
  end
  #def update
    #@post=Post.find_by(id: params[:user_id])
    #if @post.update(post_params)
        #redirect_to posts_path(@post.id)  
    #else
    #render:edit
    #end
  #end

  #def edit
    #@post=Post.find_by(id: params[:user_id])
  #end
  def destroy
    @post.destroy
    flash[:success] = "Micropost deleted"
    redirect_to request.referrer || root_url
  end
  
  private
    def post_params
       params.require(:post).permit(:content)
    end
    def correct_user
      @post = current_user.posts.find_by(id: params[:id])
      redirect_to root_url if @post.nil?
    end
end
