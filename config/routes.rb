Rails.application.routes.draw do
  resources :reviews, except: :destroy
  resources :songs, only: [:create,:show]
  resources :profiles, only: [:edit,:update,:show]
  resources :registrations, only: [:new,:create]
  resources :sessions, only: [:new,:create,:destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
