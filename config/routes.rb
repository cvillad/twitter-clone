Rails.application.routes.draw do
  devise_for :users, controllers: { 
    sessions: 'users/sessions', 
    registrations: "users/registrations",
    passwords: "users/passwords"
  } 
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "home#index"
  resources :tweets, only: [:index, :new, :create, :destroy]
  get "/:username", to: "users#show", as: "user"
  get "/users/search", to: "users#index", as: "user_search"

  namespace :users do
    get "/:username/:follow", to: "follows#index", as: "follows"
    post "/follow/:username", to: "follows#create", as: "follow"
    delete "/unfollow/:username", to: "follows#destroy", as: "unfollow"
  end

end
