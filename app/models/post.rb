# The Post model represents a blog post in the application.

class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments
  has_many :likes

  # Updates the posts_counter attribute of the associated author.
  def update_posts_counter
    author.increment!(:posts_counter)
  end

  # Returns the most recent comments for the post.
  # @param limit [Integer] The maximum number of comments to return.
  def recent_comments(limit = 5)
    comments.order(created_at: :desc).limit(limit)
  end
end
