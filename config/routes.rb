Rails.application.routes.draw do
  # root to: 'pages#home'
  root to: 'garages#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :garages do
    resources :rentals, only: %i[new create]
  end

  resources :rentals, only: %i[index edit update] do
    resources :reviews, only: %i[new create]
  end

  get '/user_garages', to: 'garages#list'
end
