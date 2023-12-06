require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  def setup
    @user = users(:john_doe)
    @post = posts(:first_post)
  end

  test 'should be valid with a user and post' do
    comment = Comment.new(user: @user, post: @post)
    assert comment.valid?, 'Comment is not valid'
  end

  test 'should not be valid without a user' do
    comment = Comment.new(post: @post)
    assert_not comment.valid?, 'Comment is valid without a user'
  end

  test 'should have an associated user' do
    comment = Comment.new(post: @post)
    assert_raises ActiveRecord::RecordInvalid, 'Validation passed unexpectedly' do
      comment.save!
    end
  end

  test 'should have an associated post' do
    comment = Comment.new(user: @user)
    assert_raises ActiveRecord::RecordInvalid, 'Validation passed unexpectedly' do
      comment.save!
    end
  end

  test 'should update post comments_counter after creation' do
    Comment.create(user: @user, post: @post)
    expected_comments_counter = @post.comments.count
    @post.reload
    assert_equal expected_comments_counter, @post.comments_counter
  end

  test 'should update post comments_counter after destruction' do
    comment = Comment.create(user: @user, post: @post)
    assert_difference('@post.reload.comments_counter', -1) do
      comment.destroy
    end
  end
end
