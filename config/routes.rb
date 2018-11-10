Rails.application.routes.draw do
  resources :localizations
  resources :messages
    devise_for :users, controllers: {
        registrations: 'users/registrations'
    }

    root to: 'application#splash'

    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
