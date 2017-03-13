Rails.application.routes.draw do
  resources :songs, only: [:create,:show] do
    resources :reviews do
      post '/vote', to: 'songs#vote'
      patch '/vote', to: 'songs#change_vote'
    end
  end
  resources :artists, only: [:index, :create, :show]
  resources :registrations, only: [:new,:create]
  resources :sessions, only: [:new,:create]

  post '/friends/search', to: 'friends#search'
  get '/friends/search', to: 'application#home'
  get '/friends/:id', to: 'friends#index', as: 'friends'
  get '/add_friend/:id', to: 'friends#create', as: 'add_friend'
  get '/remove_friend/:id', to: 'friends#destroy', as: 'remove_friend'
  get '/login', to: 'sessions#new', as: 'login'
  delete 'sessions/delete', to: 'sessions#destroy', as: 'session'
  get '/home', to: 'application#home', as: 'home'
  post '/search', to: 'spotify_api#search'
  get '/search', to: 'application#search'

  get '/my_profile', to: 'profiles#show'
  get '/profile/edit', to: 'profiles#edit'
  get '/profile/:id', to: 'profiles#show', as: 'show_profile'
  patch '/profile/:id', to: "profiles#update"
  get '/close_account', to: 'registrations#close', as: 'close_account'
  delete '/registrations', to: 'registrations#destroy'

  delete '/songs/:song_id/reviews/:id', to: 'reviews#destroy', as: 'destroy_song_review'

  root 'application#home'
end
