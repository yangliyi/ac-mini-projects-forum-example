class PostsController < ApplicationController

  before_action :authenticate_user!
  before_action :find_post, :only => [:edit, :update, :destroy]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user

    if @post.save
      flash[:notice] = "Successfully created a new post!"
      redirect_to post_path(@post)
    else
      render "new"
    end
  end

  def show
    @post = Post.includes(:comments).find(params[:id])
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:notice] = "Successfully updated your post!"
      redirect_to post_path(@post)
    else
      render "edit"
    end
  end

  def destroy
    if @post.destroy
      flash[:notice] = "Successfully destroyed this post!"
    else
      flash[:notice] = "Failed destroying the post!"
    end
    redirect_to posts_path
  end

  protected

  def post_params
    params.require(:post).permit(:title, :content, :user_id)
  end

  def find_post
    @post = current_user.posts.find(params[:id])
  end
end
