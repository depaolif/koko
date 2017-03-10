Rails.application.routes.draw do
  resources :reviews, except: :destroy
  resources :songs, only: [:create,:show] do
    resources :reviews
  end
  resources :registrations, only: [:new,:create]
  resources :sessions, only: [:new,:create,:destroy]
  get '/home', to: 'application#home', as: 'home'
  post '/search', to: 'spotify_api#search'

  get '/myprofile', to: 'profiles#index'
  get '/profile/edit', to: 'profiles#edit'
  get '/profile/:id', to: 'profiles#show', as: 'show_profile'
  post '/profile/:id', to: "profiles#update"

end
