class PostsController < ApplicationController
  include SessionsHelper
  def index
    @posts=Post.all
  end

  def new
    @post=Post.new
  end

  def show
    @post=Post.find_by(id: params[:user_id])
  end
  def create
    @post = current_user.posts.build(post_params)
    #p "==========create"
    #p  params
    @post.save!
    #p "==========create_saved"
      #p  params
     #p"============"
      #p @user.errors.full_messages
      #p"============"
    p params
    redirect_to p_show_path(@post.id)
    
    
    
  end
  def update
    @post=Post.find_by(id: params[:user_id])
    if @post.update(post_params)
        redirect_to p_show_path(@post.id)  
    else
    render:edit
    end
  end

  def edit
    @post=Post.find_by(id: params[:user_id])
  end
  def post_params
   params.require(:post).permit(:content,:user_id)
  end
end
