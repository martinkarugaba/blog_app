require 'test_helper'

class PostTest < ActiveSupport::TestCase
  def setup
    @user = users(:john_doe)
  end

  test 'should be valid with a title, comments_counter, and likes_counter' do
    post = Post.new(
      title: 'Sample Title',
      comments_counter: 2,
      likes_counter: 5,
      author: @user
    )
    assert post.valid?, 'Post is not valid'
  end

  test 'should not be valid without a title' do
    post = Post.new(comments_counter: 2, likes_counter: 5, author: @user)
    assert_not post.valid?, 'Post is valid without a title'
  end

  test 'should not be valid with a title exceeding the maximum length' do
    post = Post.new(
      title: 'a' * 251,
      comments_counter: 2,
      likes_counter: 5,
      author: @user
    )
    assert_not post.valid?, 'Post is valid with a title exceeding the maximum length'
  end

  test 'should not be valid with a negative comments_counter' do
    post = Post.new(title: 'Sample Title', comments_counter: -1, likes_counter: 5, author: @user)
    assert_not post.valid?, 'Post is valid with a negative comments_counter'
  end

  test 'should not be valid with a negative likes_counter' do
    post = Post.new(title: 'Sample Title', comments_counter: 2, likes_counter: -5, author: @user)
    assert_not post.valid?, 'Post is valid with a negative likes_counter'
  end

  test 'should be valid with zero comments_counter and likes_counter' do
    post = Post.new(title: 'Sample Title', comments_counter: 0, likes_counter: 0, author: @user)
    assert post.valid?, 'Post is not valid with zero comments_counter and likes_counter'
  end

  test 'should have recent comments in descending order' do
    post = posts(:first_post)
    recent_comments = post.recent_comments(5)

    expected_number_of_comments = 5

    assert_equal expected_number_of_comments, recent_comments.length, 'Unexpected number of recent comments'

    recent_comments.each_with_index do |comment, index|
      if index < expected_number_of_comments - 1
        assert comment.created_at >= recent_comments[index + 1].created_at, 'Comments are not in descending order'
      end
    end
  end

  test "should update author's posts_counter after creation" do
    assert_difference('@user.posts_counter', 1) do
      Post.create(
        title: 'New Post',
        comments_counter: 2,
        likes_counter: 5,
        author: @user
      )
    end
  end
end
