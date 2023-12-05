# The Post model represents a blog post in the application.
class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments
  has_many :likes

  # Callback method that is triggered after a new post is created.
  # It updates the posts_counter attribute of the associated author.
  after_create :update_posts_counter

  # Returns the most recent comments for the post.
  # The number of comments returned can be limited by passing a limit parameter.
  def recent_comments(limit = 5)
    comments.order(created_at: :desc).limit(limit)
  end

  private

  # Private method used internally to update the posts_counter attribute.
  def update_posts_counter
    author.increment!(:posts_counter)
  end
end
