Rails.application.routes.draw do
  # root to: 'pages#home'
  root to: 'garages#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :garages do
    resources :rentals, only: %i[new create]
    resources :reviews, only: %i[new create]
  end

  resources :users do
  end
end
