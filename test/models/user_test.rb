# test/models/user_test.rb

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "should be valid with a name" do
    user = User.new(name: "John Doe")
    assert user.valid?, "User is not valid with a name"
  end

  test "should have a default posts_counter of 0" do
    user = User.new(name: "John Doe")
    user.save
    assert_equal 0, user.posts_counter, "Default posts_counter is not 0"
  end

  test "should not be valid with a negative posts_counter" do
    user = User.new(name: "John Doe", posts_counter: -1)
    assert_not user.valid?, "User is valid with a negative posts_counter"
  end

  test "should be valid with a non-negative posts_counter" do
    user = User.new(name: "John Doe", posts_counter: 0)
    assert user.valid?, "User is not valid with a non-negative posts_counter"
  end

  test "should have recent posts in descending order" do
  user = users(:john_doe)
  recent_posts = user.recent_posts(3)

  assert_equal 3, recent_posts.length, "Unexpected number of recent posts"

  recent_posts.each_with_index do |post, index|
    if index < 2
      assert post.created_at >= recent_posts[index + 1].created_at, "Posts are not in descending order"
    end
  end
end
end
