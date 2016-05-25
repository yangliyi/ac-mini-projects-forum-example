class PostsController < ApplicationController

  before_action :authenticate_user!
  before_action :find_post, :only => [:edit, :update, :destroy]

  def index
    if params[:category]
      @posts = Post.includes(:categories, :user).joins(:posts_categories).where(:posts_categories => {:category_id => params[:category]} )
    else
      @posts = Post.includes(:categories, :user).all
    end

    sort_by = "updated_at DESC"
    if params[:order] && params[:order] == 'comments_count'
      sort_by = "comments_count DESC"
    elsif params[:order] && params[:order] == 'last_commented_at'
      sort_by = "last_commented_at DESC"
    end
    @posts = @posts.order(sort_by).page(params[:page]).per(5)

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
    params.require(:post).permit(:title, :content, :user_id, :category_ids => [])
  end

  def find_post
    @post = current_user.posts.find(params[:id])
  end
end
