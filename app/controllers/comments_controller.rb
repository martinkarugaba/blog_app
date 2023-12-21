class CommentsController < ApplicationController
  load_and_authorize_resource
  def new
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:post_id])
    @comment = Comment.new
  end

  def create
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:post_id])
    @comment = Comment.new(comment_params)
    @comment.user = @user
    @comment.post = @post

    if @comment.save
      redirect_to user_post_path(@user, @post), notice: 'Comment was successfully created.'
    else
      render :new
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_back(fallback_location: post_path(@post), notice: 'Comment was successfully deleted.')
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
