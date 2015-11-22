Rails.application.routes.draw do
  root "dashboard#index"
  get "/dashboard", to: "dashboard#index"

  resources :lists, only: [:new, :create, :edit, :update, :destroy] do
    resources :tasks, only: [:new, :create, :edit, :update]
  end
end
