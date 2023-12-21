Rails.application.routes.draw do
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
end
