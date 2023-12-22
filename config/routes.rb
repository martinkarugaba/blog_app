Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  devise_for :users, controllers: { registrations: "users/registrations" }
  root "users#index"

  get "/show", to: "welcome#show", as: :show_welcome

  resources :users, only: [:index, :show, :new, :create] do
    resources :posts, only: [:index, :show, :new, :create] do
      resources :comments, only: [:index, :show, :new, :create, :destroy]
    end
  end

  resources :posts do
    resources :likes, only: [:create, :destroy]
  end

  namespace :api do
    namespace :v1 do
      resources :users do
        resources :posts do
          resources :comments, only: [:index, :create]
        end
      end
    end
  end
end
