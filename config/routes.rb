Rails.application.routes.draw do
  root "welcome#index"

  resources :users, only: [:index, :show, :new, :create] do
    resources :posts, only: [:index, :show]
  end
end
