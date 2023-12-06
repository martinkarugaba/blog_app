# test/models/like_test.rb

require 'test_helper'

class LikeTest < ActiveSupport::TestCase
  def setup
    @user = users(:john_doe)
    @post = posts(:first_post)
  end

  test 'should be valid with a user and post' do
    like = Like.new(user: @user, post: @post)
    assert like.valid?, 'Like is not valid'
  end

  test 'should not be valid without a user' do
    like = Like.new(post: @post)
    assert_not like.valid?, 'Like is valid without a user'
  end

  test 'should have an associated user' do
    like = Like.new(post: @post)
    assert_raises ActiveRecord::RecordInvalid, 'Validation passed unexpectedly' do
      like.save!
    end
  end

  test 'should have an associated post' do
    like = Like.new(user: @user)
    assert_raises ActiveRecord::RecordInvalid, 'Validation passed unexpectedly' do
      like.save!
    end
  end

  test 'should update post likes_counter after creation' do
    assert_difference('@post.reload.likes_counter', 1) do
      Like.create(user: @user, post: @post)
    end
  end

  test 'should update post likes_counter after destruction' do
    like = Like.create(user: @user, post: @post)
    assert_difference('@post.reload.likes_counter', -1) do
      like.destroy
    end
  end
end
