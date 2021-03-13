Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :vaccines do
    resources :reservations
    patch "dashboard", to: 'reservations#confirm', as: 'reservation_confirm'
    patch "dashboard", to: 'reservations#cancel', as: 'reservation_cancel'
  end
  get 'dashboard', to: 'vaccines#dashboard', as: 'dashboard'
end
