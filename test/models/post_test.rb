require 'test_helper'

class PostTest < ActiveSupport::TestCase
  def setup
    @user = users(:user_one) # Replace with your fixture or create a user as needed
    @post = Post.new(
      title: 'Example Title',
      author: @user,
      comments_counter: 0,
      likes_counter: 0
    )
  end

  test 'valid post' do
    assert @post.valid?
  end

  test 'title presence' do
    @post.title = '   '
    assert_not @post.valid?
  end

  test 'title length maximum' do
    @post.title = 'a' * 251
    assert_not @post.valid?
  end

  test 'comments_counter numericality' do
    @post.comments_counter = 'abc'
    assert_not @post.valid?

    @post.comments_counter = -1
    assert_not @post.valid?

    @post.comments_counter = 1.5
    assert_not @post.valid?
  end

  test 'likes_counter numericality' do
    @post.likes_counter = 'abc'
    assert_not @post.valid?

    @post.likes_counter = -1
    assert_not @post.valid?

    @post.likes_counter = 1.5
    assert_not @post.valid?
  end
end
