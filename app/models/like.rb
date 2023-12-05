class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  # Updates the likes counter of the associated post after a like is saved or destroyed.
  after_save :update_post_likes_counter
  after_destroy :update_post_likes_counter

  private

  # Updates the likes counter of the associated post by counting the number of likes.
  def update_post_likes_counter
    post.update(likes_count: post.likes.count)
  end
end
