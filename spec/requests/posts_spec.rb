require 'rails_helper'

RSpec.describe PostsController, type: :request do
  describe 'GET /index' do
    it 'renders a successful response' do
      user = User.create!(name: 'John Doe')
      get user_posts_path(user)
      expect(response).to be_successful
    end

    it 'renders the index template' do
      user = User.create!(name: 'John Doe')
      get user_posts_path(user)
      expect(response).to render_template(:index)
    end

    it 'includes the correct placeholder text in the response body' do
      user = User.create!(name: 'John Doe')
      get user_posts_path(user)
      expect(response.body).to include('List of posts')
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      user = User.create!(name: 'John Doe')
      post = user.posts.create!(title: 'Example Post')
      get user_post_path(user, post)
      expect(response).to be_successful
    end

    it 'renders the show template' do
      user = User.create!(name: 'John Doe')
      post = user.posts.create!(title: 'Example Post')
      get user_post_path(user, post)
      expect(response).to render_template(:show)
    end

    it 'includes the correct placeholder text in the response body' do
      user = User.create!(name: 'John Doe')
      post = user.posts.create!(title: 'Example Post')
      get user_post_path(user, post)
      expect(response.body).to include('Post Details')
    end
  end
end
