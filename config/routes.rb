Rails.application.routes.draw do
  resources :reviews, except: :destroy
  resources :songs, only: [:create,:show] do
    resources :reviews
  end
  resources :profiles, only: [:edit,:update,:show]
  resources :registrations, only: [:new,:create]
  resources :sessions, only: [:new,:create]
  get '/login', to: 'sessions#new', as: 'login'
  delete 'sessions/delete', to: 'sessions#destroy', as: 'session'
  get '/home', to: 'application#home', as: 'home'
  post '/search', to: 'spotify_api#search'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
