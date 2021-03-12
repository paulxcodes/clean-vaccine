Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :vaccines do
    resources :reservations
    # collection do
    #   get :history
    # end
  end
  get 'dashboard', to: 'vaccines#dashboard', as: 'dashboard'
end
