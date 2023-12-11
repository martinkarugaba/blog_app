Rails.application.routes.draw do

  root "welcome#index"

  get 'users/:id' => 'users#index', as: 'user'

  get 'users/:user_id/posts', to: 'posts#index', as: 'user_posts'

  get 'users/:user_id/posts/:id', to: 'posts#show', as: 'user_post'
end
