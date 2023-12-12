require 'rails_helper'

RSpec.describe UsersController, type: :request do
  describe 'GET /index' do
    it 'renders a successful response' do
      get users_path
      expect(response).to be_successful
    end

    it 'renders the index template' do
      get users_path
      expect(response).to render_template(:index)
    end

    it 'includes the correct placeholder text in the response body' do
      get users_path
      expect(response.body).to include('List of users')
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      user = User.create!(name: 'John Doe')
      get user_path(user)
      expect(response).to be_successful
    end

    it 'renders the show template' do
      user = User.create!(name: 'John Doe')
      get user_path(user)
      expect(response).to render_template(:show)
    end

    it 'includes the correct placeholder text in the response body' do
      user = User.create!(name: 'John Doe')
      get user_path(user)
      expect(response.body).to include('User Details')
    end
  end

  describe 'POST /create' do
    it 'creates a new User and redirects to the created user' do
      expect do
        post users_path, params: { user: { name: 'John Doe' } }
      end.to change(User, :count).by(1)

      expect(response).to redirect_to(user_path(User.last))
    end

    it 'does not create a new User with invalid parameters' do
      expect do
        post users_path, params: { user: { name: '' } }
      end.not_to change(User, :count)
    end

    it 'renders the new template on failure' do
      post users_path, params: { user: { name: '' } }
      expect(response).to render_template(:new)
      expect(response.body).to include('New User')
      expect(response.body).to include('This is a placeholder text for the new user page.')
    end
  end
end
