# # test/models/user_test.rb

# require 'test_helper'

# class UserTest < ActiveSupport::TestCase
#   test 'should be valid with a name' do
#     user = User.new(name: 'John Doe', posts_counter: 1)
#     assert user.valid?
#   end

#   test 'should be invalid without a name' do
#     user = User.new(posts_counter: 1)
#     assert_not user.valid?
#     assert_equal ['can\'t be blank'], user.errors[:name]
#   end

#   test 'should be invalid with a non-integer posts_counter' do
#     user = User.new(name: 'John Doe', posts_counter: 'abc')
#     assert_not user.valid?
#     assert_equal ['must be an integer'], user.errors[:posts_counter]
#   end

#   test 'should be invalid with a negative posts_counter' do
#     user = User.new(name: 'John Doe', posts_counter: -1)
#     assert_not user.valid?
#     assert_equal ['must be greater than or equal to 0'], user.errors[:posts_counter]
#   end

#   test 'should create user with associated comments' do
#     user = User.new(name: 'John Doe', posts_counter: 1)
#     user.save

#     post = user.posts.create(title: 'Sample Post', text: 'This is a sample post.')
#     comment = post.comments.create(user: user, text: 'This is the first comment.')

#     assert user.valid?
#     assert post.valid?
#     assert comment.valid?
#   end
# end
