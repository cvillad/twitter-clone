Rails.application.routes.draw do
  devise_for :users, controllers: { 
    sessions: 'users/sessions', 
    registrations: "users/registrations" } 
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "home#index"
  resources :tweets
  get "/:username", to: "users#show", as: "user"
  post "/follow/:username", to: "users#follow", as: "user_follow"
  post "/unfollow/:username", to: "users#unfollow", as: "user_unfollow"
  get "/:username/following", to: "users#following", as: "user_following"
  get "/:username/followers", to: "users#followers", as: "user_followers"

end
