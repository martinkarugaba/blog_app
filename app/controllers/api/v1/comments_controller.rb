module Api
  module V1
    class CommentsController < ApplicationController
      before_action :authenticate_user!

      def index
        @post = Post.find(params[:post_id])
        render json: @post.comments
      end
    end
  end
end
