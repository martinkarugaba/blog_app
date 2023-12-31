class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  after_save :update_post_likes_counter
  after_destroy :update_post_likes_counter

  private

  def update_post_likes_counter
    post.increment!(:likes_counter) if persisted?
    post.decrement!(:likes_counter) if destroyed?
  end
end
