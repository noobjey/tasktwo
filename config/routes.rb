Rails.application.routes.draw do
  root "sessions#new"
  get "/dashboard", to: "dashboard#index"

  get "/auth/github/callback", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  resources :lists, only: [:new, :create, :edit, :update, :destroy] do
    resources :tasks, only: [:new, :create, :edit, :update]
  end
end
