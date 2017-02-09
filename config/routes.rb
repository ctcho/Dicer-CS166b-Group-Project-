Rails.application.routes.draw do
  resources :character_sheets
  resources :player_bios
  resources :dm_bios
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
