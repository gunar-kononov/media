Rails.application.routes.draw do
  resources :movies, only: :index
  resources :seasons, only: :index
  resources :purchasables, only: :index
  resources :users, only: [] do
    resources :purchases, only: [:index, :create]
  end
end
