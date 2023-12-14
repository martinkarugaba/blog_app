require 'will_paginate/array'
class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @page = params.fetch(:page, 0).to_i
    @posts = Post.limit(3).offset(@page * 3)
  end

  def show
    @post = Post.find(params[:id])
  end
end
