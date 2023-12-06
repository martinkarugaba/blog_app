require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'should be valid with a name and non-negative posts counter' do
    user = User.new(name: 'John Doe', posts_counter: 3)
    assert user.valid?
  end

  test 'should be invalid without a name' do
    user = User.new(posts_counter: 3)
    assert_not user.valid?
    assert_includes user.errors[:name], "can't be blank"
  end

  test 'should be invalid with a negative posts counter' do
    user = User.new(name: 'John Doe', posts_counter: -1)
    assert_not user.valid?
    assert_includes user.errors[:posts_counter], 'must be greater than or equal to 0'
  end

  test 'should be valid with a zero posts counter' do
    user = User.new(name: 'John Doe', posts_counter: 0)
    assert user.valid?
  end
end
