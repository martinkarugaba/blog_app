# The User model represents a user in the blog application.
class User < ApplicationRecord
  has_many :posts, foreign_key: 'author_id'
  has_many :comments
  has_many :likes

  # Returns the most recent posts created by the user.
  #
  # @param limit [Integer] the maximum number of recent posts to return (default: 3)
  # @return [ActiveRecord::Relation] a collection of recent posts
  def recent_posts(limit = 3)
    posts.order(created_at: :desc).limit(limit)
  end
end
