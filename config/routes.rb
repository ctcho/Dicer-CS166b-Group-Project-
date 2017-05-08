Rails.application.routes.draw do
  get 'search_pages/search'

  get 'search_pages/results'

  get 'home_pages/home'#fix these urls to be just home, about, etc.
  get 'home_pages/about'
  get 'home_pages/contact'
  get 'home_pages/resources'
  #get 'home_pages/unauthorized'
  get '/unauthorized', to: 'home_pages#unauthorized'
  get '/user/:user_id/settings', to: 'users#settings', as: 'settings' #fix this with routes collections or whatever
  get 'signup', to: 'users#new'
  get '/find_user', to: 'search_pages#find_by_username', as: 'find_user'
  delete '/chat_room/:id/leave', to: 'chat_rooms#remove_user', as: 'leave_chat'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  #Facebook stuff.
  get 'auth/facebook', as: "auth_provider"
  get 'auth/facebook/callback', to: 'users#facebook'

  resources :users do
    resource :player_profiles do
      resources :character_sheets
    end
    resource :messages
    resources :friendships

    resource :dm_profiles
  end
  resources :chat_rooms do
    resource :message
  end

  root 'home_pages#home'

  # serve websocket requests
  mount ActionCable.server => '/cable'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
