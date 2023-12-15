require 'will_paginate/array'
class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @page = params.fetch(:page, 0).to_i
    @posts = @user.posts.limit(3).offset(@page * 3)
  end

  def new
    @user = User.find(params[:user_id])
    @post = @user.posts.build
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.author
    @likes_count = @post.likes_counter
  end

  def like
    @post = Post.find(params[:id])
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

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
