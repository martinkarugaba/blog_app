Rails.application.routes.draw do
  root "users#index"

  get "/show", to: "welcome#show", as: :show_welcome

  resources :users, only: [:index, :show, :new, :create] do
    resources :posts, only: [:index, :show, :new, :create] do
      resources :comments, only: [:index, :show, :new, :create]
    end
  end
end
