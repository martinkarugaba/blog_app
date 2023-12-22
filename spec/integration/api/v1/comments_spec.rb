# spec/integration/api/v1/comments_spec.rb

require 'swagger_helper'

describe 'API v1 Comments', type: :request do
  fixtures :posts, :comments, :users

  def authorization_header
    { 'Authorization' => "Bearer #{token}" }
  end

  def retrieve_comments_for_post
    get 'Retrieves a list of comments for a post' do
      tags 'Comments'
      produces 'application/json'
      consumes 'application/json'
      parameter name: 'Authorization', in: :header, type: :string, required: true

      response '200', 'successful' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   content: { type: :string },
                   user: {
                     type: :object,
                     properties: {
                       id: { type: :integer },
                       email: { type: :string }
                     },
                     required: %w[id email]
                   }
                 },
                 required: %w[id content user]
               }

        let(:Authorization) { authorization_header }
        before { create_list(:comment, 3, post: posts(:one)) }
        run_test!
      end

      response '401', 'Unauthorized' do
        let(:Authorization) { '' }
        run_test!
      end

      response '404', 'Post not found' do
        let(:post_id) { 999 }
        let(:Authorization) { authorization_header }
        run_test!
      end
    end
  end

  path '/api/v1/posts/{post_id}/comments' do
    parameter name: 'post_id', in: :path, type: :integer

    describe 'GET /api/v1/posts/{post_id}/comments' do
      retrieve_comments_for_post
    end
  end

  path '/api/v1/posts/{post_id}/comments' do
    parameter name: 'post_id', in: :path, type: :integer

    describe 'POST /api/v1/posts/{post_id}/comments' do
      post 'Creates a comment for a post' do
        tags 'Comments'
        consumes 'application/json'
        parameter name: :comment, in: :body, schema: {
          type: :object,
          properties: {
            content: { type: :string }
          },
          required: ['content']
        }
        parameter name: 'Authorization', in: :header, type: :string, required: true

        response '201', 'created' do
          let(:comment) { { content: 'New Comment' } }
          let(:Authorization) { authorization_header }

          run_test!
        end

        response '401', 'Unauthorized' do
          let(:comment) { { content: 'New Comment' } }
          let(:Authorization) { '' }

          run_test!
        end

        response '422', 'unprocessable entity' do
          let(:comment) { { content: nil } }
          let(:Authorization) { authorization_header }

          run_test!
        end
      end
    end
  end
end
