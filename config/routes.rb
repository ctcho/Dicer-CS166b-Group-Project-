Rails.application.routes.draw do
  get 'search_pages/search'

  get 'search_pages/results'

  get 'home_pages/home'#fix these urls to be just home, about, etc.
  get 'home_pages/about'
  get 'home_pages/contact'
  get 'home_pages/resources'
  #get 'home_pages/unauthorized'
  get '/unauthorized', to: 'homepages#unauthorized'
  get '/user/:user_id/settings', to: 'users#settings' #fix this with routes collections or whatever
  get 'signup', to: 'users#new'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users do
    resource :player_profiles do
      resources :character_sheets
    end
    resource :dm_profiles
  end

  root 'home_pages#home'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
