require 'will_paginate/array'
class PostsController < ApplicationController
  load_and_authorize_resource

  def index
    @user = User.find(params[:user_id])
    @page = params.fetch(:page, 0).to_i
    @posts = @user.posts.includes(:comments).limit(3).offset(@page * 3)
  end

  def new
    @user = User.find(params[:user_id])
    @post = @user.posts.build
  end

  def show
    @post = Post.includes(:author).find(params[:id])
    @user = @post.author
    @likes_count = @post.likes_counter
  end

  def like
    @post = Post.includes(:author).find(params[:id])
    @like = Like.create(user: current_user, post: @post)

    respond_to do |format|
      format.json { render json: { likes_count: @post.likes.count } }
    end
  end

  def create
    @user = User.find(params[:user_id])
    @post = @user.posts.build(post_params)

    if @post.save
      redirect_to user_posts_path(@user)
    else
      render :new
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: 'Post was successfully deleted.'
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
