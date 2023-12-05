class User < ApplicationRecord
  # Represents a user in the system.
  # A user can have multiple posts, comments, and likes.

  has_many :posts, foreign_key: 'author_id'
  has_many :comments
  has_many :likes

  # Returns the most recent posts created by the user.
  # @param limit [Integer] the maximum number of recent posts to return (default: 3)
  def recent_posts(limit = 3)
    posts.order(created_at: :desc).limit(limit)
  end
end
