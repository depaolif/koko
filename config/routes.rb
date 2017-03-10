Rails.application.routes.draw do
  resources :reviews, except: :destroy
  resources :songs, only: [:create,:show] do
    resources :reviews
  end

  resources :registrations, only: [:new,:create]
  resources :sessions, only: [:new,:create]
  get '/login', to: 'sessions#new', as: 'login'
  delete 'sessions/delete', to: 'sessions#destroy', as: 'session'
  get '/home', to: 'application#home', as: 'home'
  post '/search', to: 'spotify_api#search'

  get '/myprofile', to: 'profiles#index'
  get '/profile/edit', to: 'profiles#edit'
  get '/profile/:id', to: 'profiles#show', as: 'show_profile'
  patch '/profile/:id', to: "profiles#update"
  get '/close_account', to: 'registrations#close', as: 'close_account'
  delete '/registrations', to: 'registrations#destroy'

  root 'application#home'
end
