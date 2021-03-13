Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :vaccines do
    resources :reservations
  end
  get 'dashboard', to: 'dashboard#dashboard', as: 'dashboard'
  patch "reservations/:id/confirm", to: 'dashboard#confirm', as: 'reservation_confirm'
  patch "reservations/:id/cancel", to: 'dashboard#cancel', as: 'reservation_cancel'
end
