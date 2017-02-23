Rails.application.routes.draw do
  get 'home_pages/home'

  get 'home_pages/about'

  get 'home_pages/contact'

  get 'home_pages/resources'

  resources :character_sheets
  resources :player_profiles
  resources :dm_profiles
  resources :users

  root 'home_pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
