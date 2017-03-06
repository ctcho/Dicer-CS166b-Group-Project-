Rails.application.routes.draw do
  root 'home_pages#home'
  get 'home_pages/home'

  get 'home_pages/about'

  get 'home_pages/contact'

  get 'home_pages/resources'

  resources :users do
    resource :player_profiles do
      resources :character_sheets
    end
    resource :dm_profiles
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
