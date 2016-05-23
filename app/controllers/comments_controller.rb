class CommentsController < ApplicationController

  before_action :authenticate_user!
  before_action :find_post

  def create
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      flash[:notice] = "Successfully created your new comment!"
    else
      flash[:alert] = "Sorry you failed creating your new comment. Please notice that content can not be blank."
    end

    redirect_to post_path(@post)
  end

  def update
    @comment = @post.comments.find(params[:id])
    if @comment.update(comment_params)
      flash[:notice] = "Successfully updated your comment!"
    else
      flash[:alert] = "Sorry you failed updating your comment!"
    end

    redirect_to post_path(@post)
  end

  def destroy
    @comment = current_user.comments.where(:post_id => params[:post_id]).find(params[:id])
    @comment.destroy

    redirect_to post_path(@post)
  end

  protected

  def comment_params
    params.require(:comment).permit(:content, :user_id, :post_id)
  end

  def find_post
    @post = Post.find(params[:post_id])
  end
end
