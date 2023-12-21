module Api
  module V1
    class CommentsController < ApplicationController
      def index
        @post = Post.find(params[:post_id])
        render json: @post.comments
      end

      def create        
        @post = Post.find(params[:post_id])        
        @comment = @post.comments.create(comment_params)     
        @comment.user = current_user        
        if @comment.save          
          render json: @comment, status: :created       
        else          
          render json: @comment.errors, status: :unprocessable_entity        
        end   
      end   

      private
      def comment_params    
        params.require(:comment).permit(:content)     
      end
      
    end
  end
end
