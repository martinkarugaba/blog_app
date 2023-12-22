require 'swagger_helper'

describe 'API v1 Posts', type: :request do
  fixtures :users, :posts, :comments

  path '/api/v1/users/{user_id}/posts' do
    parameter name: 'user_id', in: :path, type: :integer

    describe 'GET /api/v1/users/{user_id}/posts' do
      let(:user) { users(:user1) }
      let(:user_id) { user.id }
      let(:Authorization) { "Bearer #{token}" } # Replace with your authentication token

      before do
        user.posts.each { |post| post.comments = comments(:comment1, :comment2) }
      end

      context 'when user is authenticated' do
        it 'returns a list of posts for a user', :aggregate_failures do
          get '/api/v1/users/{user_id}/posts', headers: { 'Authorization' => Authorization }

          expect(response).to have_http_status(200)
          expect(response).to match_response_schema('posts') # Assuming you use a JSON schema
          expect(json_response.count).to eq(3)
          # Add more expectations as needed
        end
      end

      context 'when user is not authenticated' do
        it 'returns unauthorized', :aggregate_failures do
          get '/api/v1/users/{user_id}/posts', headers: { 'Authorization' => '' }

          expect(response).to have_http_status(401)
        end
      end

      context 'when user is not found' do
        it 'returns not found', :aggregate_failures do
          get '/api/v1/users/{user_id}/posts', headers: { 'Authorization' => Authorization }

          expect(response).to have_http_status(404)
        end
      end
    end
  end
end
