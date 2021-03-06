Rails.application.routes.draw do

  # Serve websocket cable requests in-process
  mount ActionCable.server => '/cable'

  resources :songs, only: [:create,:show] do
    resources :reviews, except: [:index, :new, :edit] do
      post '/vote', to: 'songs#vote'
      patch '/vote', to: 'songs#change_vote'
    end
  end
  resources :artists, only: [:create, :show]
  resources :registrations, only: [:new,:create]
  resources :sessions, only: [:new,:create]

  get '/trendingsongs', to: 'songs#trending_songs'
  get '/trendingartists', to: 'artists#trending'
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
