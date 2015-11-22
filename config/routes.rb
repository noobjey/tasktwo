Rails.application.routes.draw do
  get "/dashboard", to: "dashboard#index"

  resources :lists, only: [:new, :create, :edit, :update, :destroy] do
    resources :tasks, only: [:new, :create]
  end
end
