# spec/features/user_show_spec.rb
require 'rails_helper'

RSpec.describe 'User Show Page', type: :feature do
  fixtures :users, :posts

  before do
    @user = users(:john_doe)
    visit user_path(@user)
  end

  describe 'User Details Section' do
    it 'I can see the user\'s profile picture' do
      expect_user_profile_picture(@user)
    end

    it 'I can see the user\'s username' do
      expect_user_username(@user)
    end

    it 'I can see the number of posts the user has written' do
      expect_user_posts_count(@user)
    end

    it 'I can see the user\'s bio' do
      expect_user_bio(@user)
    end

    it 'I can see the user\'s first 3 posts' do
      expect_user_first_three_posts(@user)
    end
  end

  describe 'Actions Section' do
    it 'I can see a button that lets me view all of a user\'s posts' do
      expect_user_all_posts_button(@user)
    end

    it 'When I click a user\'s post, it redirects me to that post\'s show page' do
      click_user_post_redirect(@user)
    end

    it 'When I click to see all posts, it redirects me to the user\'s post\'s index page' do
      click_all_posts_redirect(@user)
    end
  end

  private

  # Helper methods go here
end
