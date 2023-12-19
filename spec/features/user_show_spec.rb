require 'rails_helper'
RSpec.describe 'User Show Page', type: :feature do
  fixtures :users, :posts
  before do
    @user = users(:john_doe)
    visit user_path(@user)
  end
  it 'I can see the user\'s profile picture' do
    expect(page).to have_selector("img[src='#{@user.photo}']")
  end
  it 'I can see the user\'s username' do
    expect(page).to have_content(@user.name)
  end
  it 'I can see the number of posts the user has written' do
    expect(page).to have_content("Number of Posts: #{@user.posts.count}")
  end
  it 'I can see the user\'s bio' do
    expect(page).to have_content("Bio: #{@user.bio}")
  end
  it 'I can see the user\'s first 3 posts' do
    @user.recent_posts.limit(3).each do |post|
      expect(page).to have_content(post.title)
      expect(page).to have_content(post.text)
    end
  end
  it 'I can see a button that lets me view all of a user\'s posts' do
    expect(page).to have_link('All Posts', href: user_posts_path(@user))
  end
  it 'When I click a user\'s post, it redirects me to that post\'s show page' do
    post = @user.posts.first
    click_link post.title
    expect(page).to have_current_path(user_post_path(@user, post))
  end
  it 'When I click to see all posts, it redirects me to the user\'s post\'s index page' do
    click_link 'All Posts'
    expect(page).to have_current_path(user_posts_path(@user))
  end
  private
  def expect_user_profile_picture(user)
    expect(page).to have_selector("img[src='#{user.photo}']")
  end
  def expect_user_username(user)
    expect(page).to have_content(user.name)
  end
  def expect_user_posts_count(user)
    expect(page).to have_content("#{user.posts_counter} posts")
  end
  def expect_user_bio(user)
    expect(page).to have_content("Bio: #{user.bio}")
  end
  def expect_user_first_three_posts(user)
    user.recent_posts.limit(3).each do |post|
      expect(page).to have_content(post.title)
      expect(page).to have_content(post.text)
    end
  end
  def expect_user_all_posts_button(user)
    expect(page).to have_link('All Posts', href: user_posts_path(user))
  end
  def click_user_post_redirect(user)
    post = user.recent_posts.first
    click_link post.title
    expect(page).to have_current_path(post_path(post))
  end
end
