require 'rails_helper'

RSpec.feature 'User Index Page', type: :feature do
  fixtures :users

  before do
    visit users_path
  end

  scenario 'I can see the username of all other users' do
    expect(page).to have_content(users(:john_doe).name)
    expect(page).to have_content(users(:jane_smith).name)
  end

  scenario 'I can see the profile picture for each user' do
    expect(page).to have_selector("img[src='#{users(:john_doe).photo}']")
    expect(page).to have_selector("img[src='#{users(:jane_smith).photo}']")
  end

  scenario 'I can see the number of posts each user has written' do
    expect(page).to have_content("#{users(:john_doe).posts_counter} posts")
    expect(page).to have_content("#{users(:jane_smith).posts_counter} posts")
  end

  scenario 'When I click on a user, I am redirected to that user\'s show page' do
    click_link users(:john_doe).name
    expect(page).to have_current_path(user_path(users(:john_doe)))
  end
end
