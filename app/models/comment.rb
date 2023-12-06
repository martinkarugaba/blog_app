# The Comment model represents a comment made by a user on a post.
class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :user_id, presence: true

  # Updates the comments counter of the associated post after saving or deleting a comment.
  # after_save :update_post_comments_counter
  # after_destroy :update_post_comments_counter

  private

  def update_post_comments_counter
    post.update(comments_count: post.comments.count)
  end
end
