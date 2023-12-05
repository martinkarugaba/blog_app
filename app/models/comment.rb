# The Comment class represents a comment made by a user on a post in the blog app.

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  # Callback method that is triggered after a comment is saved or destroyed.
  # It updates the comments_count attribute of the associated post
  after_save :update_post_comments_counter
  after_destroy :update_post_comments_counter

  private

  # Private method that updates the comments_count attribute of the associated post.
  def update_post_comments_counter
    post.update(comments_count: post.comments.count)
  end
end
