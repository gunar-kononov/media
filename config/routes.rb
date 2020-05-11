Rails.application.routes.draw do
  # Default version should always be at the bottom
  scope module: :v1, constraints: VersionConstraint.new(version: 1, default: true) do
    resources :movies, only: :index
    resources :seasons, only: :index
    resources :purchasables, only: :index
    resources :users, only: [] do
      resources :purchases, only: [:index, :create]
    end
  end
end
