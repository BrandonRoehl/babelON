Rails.application.routes.draw do
    mount ActionCable.server, at: '/cable'

    devise_for :users, controllers: {
        registrations: 'users/registrations'
    }

    resources :conversations
    resources :localizations
    resources :messages

    root to: 'conversations#index'

    post :send_msg, to: 'api#send_msg', as: :send_msg
    get :send_msg,  to: 'api#make_msg'

    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
