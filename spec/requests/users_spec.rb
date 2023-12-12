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
end
