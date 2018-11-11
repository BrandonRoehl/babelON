Rails.application.routes.draw do
    devise_for :users, controllers: {
        registrations: 'users/registrations'
    }

    root to: 'application#splash'

    resources :localizations
    resources :messages
    resources :conversations
    mount ActionCable.server, at: '/cable'
    post :send_msg, to: 'api#send_msg', as: :send_msg
    get :send_msg,  to: 'api#make_msg'

    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
