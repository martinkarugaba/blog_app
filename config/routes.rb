Rails.application.routes.draw do
  root "welcome#index"

  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show]
  end
end
