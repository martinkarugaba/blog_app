# app/controllers/likes_controller.rb
class LikesController < ApplicationController
  def create
    @like = Like.create(user_id: params[:user_id], post_id: params[:post_id])
    redirect_to posts_path
  end

  def destroy
    @like = Like.find(params[:id])
    @like.destroy
    redirect_to posts_path
  end
end
