Rails.application.routes.draw do
  get "/dashboard", to: "dashboard#index"

  resources :lists, only: [:new, :create, :edit, :update, :destroy]
end
