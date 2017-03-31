Rails.application.routes.draw do
  get 'search_pages/search'

  get 'search_pages/results'

  get 'home_pages/home'
  get 'home_pages/about'
  get 'home_pages/contact'
  get 'home_pages/resources'
  get 'home_pages/unauthorized'

  get 'signup', to: 'users#new'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users do
    resource :player_profiles do
      resources :character_sheets
    end
    resource :message
    resource :dm_profiles
  end

  root 'home_pages#home'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
