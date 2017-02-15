Rails.application.routes.draw do
  resources :character_sheets
  resources :player_profiles
  resources :dm_profiles
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
