require 'rails_helper'

RSpec.describe 'User Post Index Page', type: :feature do
  fixtures :users, :posts

  before do
    @user = users(:john_doe)
    @posts = @user.posts.page(1)
    visit user_posts_path(@user)
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

  it 'I can see a post\'s title' do
    post = @posts.fifth
    visit user_posts_path(@user)
    click_link 'Next'
    expect(page).to have_content(post.title)
  end

  it 'I can see some of the post\'s body' do
    post = @posts.first
    visit user_posts_path(@user)
    expect(page).to have_content(post.text[0..10])
  end

  it 'I can see the first comments on a post' do
    post = @posts.first
    post.recent_comments.each do |comment|
      expect(page).to have_content(comment.text)
    end
  end

  it 'I can see how many comments a post has' do
    post = @posts.first
    expect(page).to have_content("Comments: #{post.comments.count}")
  end

  it 'I can see how many likes a post has' do
    post = @posts.first
    visit user_posts_path(@user)
    expect(page).to have_content("Like\n#{post.likes.count}")
  end

  it 'I can see a section for pagination if there are more posts than fit on the view' do
    visit user_posts_path(@user)
    expect(page).to have_link('Next')
    expect(page).to have_link('Prev') if @page.to_i > 0
  end

  it 'When I click on a post, it redirects me to that post\'s show page' do
    post = posts(:first_post)
    visit user_posts_path(@user)
    expect(page).to have_link(post.title)
    click_link post.title
    expect(page).to have_current_path(user_post_path(@user, post))
  end
end
